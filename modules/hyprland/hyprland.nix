{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  cursor = "Bibata-Modern-Ice";
  cursor_size = 24;
in {
  imports = [
    ../waybar/waybar.nix
    ../mako.nix
    ./xdg-portal.nix
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
        type = lib.types.str;
        default = "eDP-1, 1920x1080@60, 0x0, 1";
        description = "monitor used by hyprland";
      };
      sensitivity = lib.mkOption {
        type = lib.types.float;
        default = "0.0";
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
    ];

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
      xwayland.enable = true;
      withUWSM = true;
    };

    home-manager.users.freddy = {
      home.file."${config.users.users.freddy.home}/.local/share/icons/${cursor}" = {
        source = ./${cursor};
        recursive = true;
      };

      home.file."${config.users.users.freddy.home}/.icons/${cursor}" = {
        source = ./${cursor};
        recursive = true;
      };

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
          ipc = "off"; # turns off cli communication
          preload = [(builtins.toPath ./wallpaper/nixos-background.png)];
          # the , here omits the monitor, meaning put the wallpaper on the primary monitor
          wallpaper = [",${builtins.toPath ./wallpaper/nixos-background.png}"];
        };
      };

      wayland.windowManager.hyprland = {
        enable = true;

        settings = {
          "exec-once" = [
            "waybar &"
            "mako &"
            "hyprctl setcursor ${cursor} ${builtins.toString cursor_size}"
          ];

          monitor = config.hyprland.monitor;

          "$terminal" = "alacritty";
          "$fileManager" = "dolphin";
          "$menu" = "wofi --show drun --insensitive";

          env = [
            "XCURSOR_THEME,${cursor}"
            "HYPRCURSOR_THEME,${cursor}"
            "XCURSOR_SIZE,${builtins.toString cursor_size}"
            "HYPRCURSOR_SIZE,${builtins.toString cursor_size}"
            "XDG_CURRENT_DESKTOP,Hyprland"
            "XDG_SESSION_TYPE,wayland"
          ];

          general = {
            gaps_in = 0;
            gaps_out = 0;
            border_size = 2;
            "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
            "col.inactive_border" = "rgba(595959aa)";
            resize_on_border = false;
            allow_tearing = false;
            layout = "master";
          };

          animations = {
            enabled = "yes, please :)";
            bezier = [
              "easeOutQuint, 0.23, 1, 0.32, 1"
              "easeInOutCubic, 0.65, 0.05, 0.36, 1"
              "linear, 0, 0, 1, 1"
              "almostLinear, 0.5, 0.5, 0.75, 1"
              "quick, 0.15, 0, 0.1, 1"
            ];

            animation = [
              "global, 1, 10, default"
              "border, 1, 5.39, easeOutQuint"
              "windows, 1, 4.79, easeOutQuint"
              "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
              "windowsOut, 1, 1.49, linear, popin 87%"
              "fadeIn, 1, 1.73, almostLinear"
              "fadeOut, 1, 1.46, almostLinear"
              "fade, 1, 3.03, quick"
              "layers, 1, 3.81, easeOutQuint"
              "layersIn, 1, 4, easeOutQuint, fade"
              "layersOut, 1, 1.5, linear, fade"
              "fadeLayersIn, 1, 1.79, almostLinear"
              "fadeLayersOut, 1, 1.39, almostLinear"
              "workspaces, 1, 1.94, almostLinear, fade"
              "workspacesIn, 1, 1.21, almostLinear, fade"
              "workspacesOut, 1, 1.94, almostLinear, fade"
              "zoomFactor, 1, 7, quick"
            ];
          };

          master = {
            mfact = 0.5;
            new_status = "slave";
          };

          misc = {
            force_default_wallpaper = -1;
            disable_hyprland_logo = false;
          };

          input = {
            kb_layout = config.hyprland.kb_layout;
            kb_variant = "";
            kb_model = "";
            kb_options = "";
            kb_rules = "";
            follow_mouse = 1;
            sensitivity = config.hyprland.sensitivity;

            touchpad = {
              natural_scroll = false;
            };
          };

          debug = {
            disable_logs = false;
          };

          "$mainMod" = "SUPER";

          bind = [
            "$mainMod, Return, exec, $terminal"
            "$mainMod, Q, killactive,"
            "$mainMod, E, exec, $fileManager"
            "$mainMod, V, togglefloating,"
            "$mainMod, P, exec, $menu"
            "$mainMod, J, togglesplit,"
            "$mainMod, F, fullscreen"

            ", PRINT, exec, hyprshot -m region --clipboard-only"

            "$mainMod, left, movefocus, l"
            "$mainMod, right, movefocus, r"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"

            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod, 6, workspace, 6"
            "$mainMod, 7, workspace, 7"
            "$mainMod, 8, workspace, 8"
            "$mainMod, 9, workspace, 9"
            "$mainMod, 0, workspace, 10"

            "$mainMod SHIFT, 1, movetoworkspace, 1"
            "$mainMod SHIFT, 2, movetoworkspace, 2"
            "$mainMod SHIFT, 3, movetoworkspace, 3"
            "$mainMod SHIFT, 4, movetoworkspace, 4"
            "$mainMod SHIFT, 5, movetoworkspace, 5"
            "$mainMod SHIFT, 6, movetoworkspace, 6"
            "$mainMod SHIFT, 7, movetoworkspace, 7"
            "$mainMod SHIFT, 8, movetoworkspace, 8"
            "$mainMod SHIFT, 9, movetoworkspace, 9"
            "$mainMod SHIFT, 0, movetoworkspace, 10"

            "$mainMod, S, togglespecialworkspace, magic"
            "$mainMod SHIFT, S, movetoworkspace, special:magic"

            "$mainMod, mouse_down, workspace, e+1"
            "$mainMod, mouse_up, workspace, e-1"
          ];

          bindm = [
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
          ];

          bindel = [
            ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
            ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
            ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
          ];

          bindl = [
            ",XF86AudioNext, exec, playerctl next"
            ",XF86AudioPause, exec, playerctl play-pause"
            ",XF86AudioPlay, exec, playerctl play-pause"
            ",XF86AudioPrev, exec, playerctl previous"
          ];

          windowrule = [
            "match:class .*, suppress_event maximize"
            "match:class ^$ match:title ^$ match:xwayland true match:floating true match:fullscreen false match:pinned false, no_focus true" # fixes dragging issues with xwayland
            "match:class .*, suppress_event maximize" # ignore maximise requests from apps
            "match:workspace w[t1], border_size 0" # no border when there's only one window

            # https://wiki.hypr.land/Useful-Utilities/Screen-Sharing/#xwayland
            "match:class ^(xwaylandvideobridge)$, opacity 0.0 override"
            "match:class ^(xwaylandvideobridge)$, no_anim true"
            "match:class ^(xwaylandvideobridge)$, no_initial_focus true"
            "match:class ^(xwaylandvideobridge)$, max_size 1 1"
            "match:class ^(xwaylandvideobridge)$, no_blur true"
            "match:class ^(xwaylandvideobridge)$, no_focus true"

            "match:class ^(shooter-game-editor)$, float true"
          ];
        };
      };
    };
  };
}
