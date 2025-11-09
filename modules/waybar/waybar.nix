{
  config,
  pkgs,
  inputs,
  ...
}: {
  home-manager.users.freddy = {
    programs.waybar = {
      enable = true;
      systemd.enableDebug = true;
      # based on https://github.com/mechakotik/dots/tree/c91b980c3bd1bb6792df9ba21fe537f0242c42aa
      settings = [
        {
          layer = "top";
          position = "top";
          spacing = 5;

          "modules-left" = ["hyprland/workspaces"];
          "modules-center" = ["clock"];
          "modules-right" = ["wireplumber" "battery" "network" "bluetooth" "tray"];

          "hyprland/workspaces" = {
            "on-click" = "activate";
            "sort-by-number" = true;
            "persistent-workspaces" = {
              "1" = [];
              "2" = [];
              "3" = [];
              "4" = [];
              "5" = [];
            };
          };

          clock = {
            format = "{:%H:%M | %d/%m/%Y}";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                "months" = "<span color='#ffead3'><b>{}</b></span>";
                "days" = "<span color='#ecc6d9'><b>{}</b></span>";
                "weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
                "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
                "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
            };
          };

          wireplumber = {
            format = " {volume}%";
            "max-volume" = 100;
            "scroll-step" = 5;
          };

          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            # format-discharging = "{capacity}% {icon}";
            # format-charging = "{capacity}% {icon}";
            format = "{capacity}% {icon}";
            format-icons = {
              default = ["󱊡" "󱊢" "󱊣"];
              charging = ["󱊤" "󱊥" "󱊦"];
            };
          };

          memory = {
            interval = 30;
            format = "  {used:0.1f}G";
          };

          network = {
            format = "";
            "format-ethernet" = "󰈀";
            "format-wifi" = "{icon}";
            "format-disconnected" = "󰤮";
            "format-icons" = ["󰤟" "󰤢" "󰤥" "󰤨"];
            "tooltip-format-wifi" = "{essid} ({signalStrength}%)";
            "tooltip-format-ethernet" = "{ifname}";
            "tooltip-format-disconnected" = "Disconnected";
          };

          bluetooth = {
            format = ""; # do not show when disconnected
            "format-disabled" = "󰂲";
            "format-connected" = "󰂯";
            "tooltip-format" = "{controller_alias}\t{controller_address}";
            "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
            "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
          };

          tray = {
            "icon-size" = 16;
            spacing = 16;
          };
        }
      ];

      style = ''
        @define-color foreground #eeeeee;
        @define-color foreground-inactive #aaaaaa;
        @define-color background #000000;

        * {
            font-family: SFMono Nerd Font;
            font-size: 14px;
            padding: 0;
            margin: 0;
        }

        #waybar {
            color: @foreground;
            background-color: @background;
        }

        #workspaces button {
            color: @foreground;
            padding-left: 0.7em;
        }

        #workspaces button.empty {
            color: @foreground-inactive;
        }

        #memory,
        #custom-platform-profile {
            padding-left: 1em
        }

        #wireplumber,
        #battery,
        #idle_inhibitor,
        #language,
        #network,
        #bluetooth,
        #tray {
            padding-right: 1em
        }
      '';
    };
  };
}
