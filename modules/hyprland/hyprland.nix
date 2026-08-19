{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  gtk_theme = {
    package = pkgs.orchis-theme;
    name = "Orchis-Dark";
  };
in {
  imports = [
    ../waybar/waybar.nix
    ../mako.nix
  ];

  options = {
    hyprland = {
      enable = lib.mkEnableOption "enable hyprland";
      kb_layout = lib.mkOption {
        type = lib.types.str;
        default = "gb";
        description = "keyboard layout used by hyprland";
      };
      monitor = lib.mkOption {
        description = "monitor used by hyprland";

        type = lib.types.submodule {
          options = {
            output = lib.mkOption {
              type = lib.types.str;
            };
            mode = lib.mkOption {
              type = lib.types.str;
            };
            position = lib.mkOption {
              type = lib.types.str;
            };
            scale = lib.mkOption {
              type = lib.types.float;
            };
          };
        };

        default = {
          output = "eDP-1";
          mode = "1920x1080@60";
          position = "0x0";
          scale = 1.0;
        };
      };
      sensitivity = lib.mkOption {
        type = lib.types.float;
        default = 0.0;
        description = "mouse sensitivity";
      };
    };
  };

  config = lib.mkIf config.hyprland.enable {
    environment.systemPackages = [
      pkgs.kitty # default terminal for hyprland
      pkgs.wofi # run menu
      pkgs.hyprcursor
      pkgs.hyprshot
      pkgs.hyprprop
      pkgs.hyprlock
    ];

    programs.hyprland = {
      enable = true;
      # set the flake package
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
      xdgOpenUsePortal = true;
      configPackages = [config.programs.hyprland.package];
      config.hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.OpenURI" = "gtk";
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
        "org.freedesktop.impl.portal.Print" = "gtk";
      };
    };

    home-manager.users.freddy = {
      home.pointerCursor = {
        enable = true;
        gtk.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 16;
      };

      gtk = {
        enable = true;

        theme = gtk_theme;
        gtk4.theme = gtk_theme;

        iconTheme = {
          package = pkgs.adwaita-icon-theme;
          name = "Adwaita";
        };

        font = {
          name = "Sans";
          size = 11;
        };
      };

      # Required for polkit to prompt for sudo permissions
      services.hyprpolkitagent.enable = true;

      services.hyprsunset = {
        enable = true;
        settings = {
          max-gamma = 150;

          profile = [
            {
              time = "7:30";
              identity = true;
            }
            {
              time = "21:00";
              temperature = 5000;
              gamma = 0.8;
            }
          ];
        };
      };

      services.hyprpaper = {
        enable = true;
        settings = {
          # ipc = "off"; # turns off cli communication
          wallpaper = [
            {
              fit_mode = "cover";
              monitor = "DP-2";
              path = toString ./wallpaper/so-hard.jpg;
            }
          ];
        };
      };

      services.hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
            before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
            after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'"; # to avoid having to press a key twice to turn on the display.
          };

          listener = [
            {
              timeout = 150; # 2.5min.
              on-timeout = "brightnessctl -s set 10"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
              on-resume = "brightnessctl -r"; # monitor backlight restore.
            }
            {
              timeout = 300; # 5min
              on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
            }
            {
              timeout = 330; # 5.5min
              on-timeout = "hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })'"; # screen off when timeout has passed
              on-resume = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })' && brightnessctl -r"; # screen on when activity is detected after timeout has fired.
            }
            {
              timeout = 1800; # 30min
              on-timeout = "systemctl suspend"; # suspend pc
            }
          ];
        };
      };

      wayland.windowManager.hyprland = {
        enable = true;
        # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
        package = null;
        portalPackage = null;

        configType = "lua";

        extraConfig = ''
          hl.monitor({
              output = "${config.hyprland.monitor.output}",
              mode = "${config.hyprland.monitor.mode}",
              position = "${config.hyprland.monitor.position}",
              scale = ${lib.strings.floatToString config.hyprland.monitor.scale},
          })

          hl.on("hyprland.start", function ()
              hl.exec_cmd("waybar &")
              hl.exec_cmd("mako &")
              hl.exec_cmd("wl-paste --type text --watch cliphist store")
              hl.exec_cmd("wl-paste --type image --watch cliphist store")
          end)

          hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
          hl.env("XDG_SESSION_TYPE", "wayland")

          hl.config({
              general = {
                  gaps_in = 0,
                  gaps_out = 0,
                  border_size = 2,
                  col = {
                      active_border = { colors = {"rgba(33ccffff),  rgba(00ff99ff)}, angle = 45 },
                      inactive_border = "rgba(595959ff)",
                  },
                  resize_on_border = false,
                  allow_tearing = false,
                  layout = "master",
              },

              animations = {
                  enabled = true,
              },

              master = {
                mfact = 0.5,
                new_status = "slave",
              },

              misc = {
                disable_hyprland_logo = true,
                disable_splash_rendering = true,
              },

              input = {
                kb_layout = ${config.hyprland.kb_layout},
                kb_variant = "",
                kb_model = "",
                kb_options = "",
                kb_rules = "",
                follow_mouse = 1,
                sensitivity = ${lib.strings.floatToString config.hyprland.sensitivity},

                touchpad = {
                  natural_scroll = false,
                },
              },

              debug = {
                disable_logs = false,
              },
          })

          hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
          hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
          hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
          hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
          hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

          -- Default springs
          hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

          hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
          hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
          hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
          hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
          hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
          hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
          hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
          hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
          hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
          hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
          hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
          hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
          hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
          hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
          hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
          hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
          hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

          local mainMod = "SUPER"
          hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("alacritty"))
          hl.bind(mainMod .. " + Q", hl.dsp.window.close())
          hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("dolphin"))
          hl.bind(mainMod .. " + B", hl.dsp.window.float({ action = "toggle" }))
          hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("wofi --show drun --insensitive"))
          hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
          hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle"}))
          hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | wofi -dmenu | cliphist decode | wl-copy"))

          hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))

          hl.bind(mainMod .. " + left", hl.dps.focus({ direction = "left" }))
          hl.bind(mainMod .. " + right", hl.dps.focus({ direction = "right" }))
          hl.bind(mainMod .. " + up", hl.dps.focus({ direction = "up" }))
          hl.bind(mainMod .. " + down", hl.dps.focus({ direction = "down" }))

          for i = 1, 10 do
              local key = i % 10 -- 10 maps to key 0
              hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
              hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
          end

          hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
          hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

          hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+", { locked = true, repeating = true })
          hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-", { locked = true, repeating = true })
          hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
          hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
          hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
          hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

          hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
          hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
          hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
          hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

          -- Ignore maximize requests from all apps. You'll probably like this.
          hl.window_rule({
              name  = "suppress-maximize-events",
              match = { class = ".*" },

              suppress_event = "maximize",
          })

          -- Fix some dragging issues with XWayland
          hl.window_rule({
              name  = "fix-xwayland-drags",
              match = {
                  class      = "^$",
                  title      = "^$",
                  xwayland   = true,
                  float      = true,
                  fullscreen = false,
                  pin        = false,
              },

              no_focus = true,
          })

          hl.window_rule({
              name = "no-border-single-window",
              match = {
                  workspace = "w[t1]",
              },

              border_size = 0,
          })

          hl.window_rule({
              name = "shooter-game-editor-float",
              match = {
                  class = "^(shooter-game-editor)$",
              },

              float = true,
          })
        '';
      };
    };
  };
}
