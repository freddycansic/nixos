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
          height = 24;
          spacing = 5;

          "modules-left" = ["hyprland/workspaces"];
          "modules-center" = ["clock"];
          "modules-right" = ["wireplumber" "battery" "hyprland/language" "idle_inhibitor" "network" "bluetooth" "tray"];

          "hyprland/workspaces" = {
            format = "<span size='larger'>{icon}</span>";
            "on-click" = "activate";
            "icon-size" = 10;
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
            format = "{:%d.%m.%Y | %H:%M}";
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
            format = "\uf4bc  {used:0.1f}G";
          };

          network = {
            format = "";
            "format-ethernet" = "\udb83\udc9d";
            "format-wifi" = "{icon}";
            "format-disconnected" = "\udb83\udc9c";
            "format-icons" = ["\udb82\udd2f" "\udb82\udd1f" "\udb82\udd22" "\udb82\udd25" "\udb82\udd28"];
            "tooltip-format-wifi" = "{essid} ({signalStrength}%)";
            "tooltip-format-ethernet" = "{ifname}";
            "tooltip-format-disconnected" = "Disconnected";
          };

          bluetooth = {
            format = "\udb80\udcaf";
            "format-disabled" = "\udb80\udcb2";
            "format-connected" = "\udb80\udcb1";
            "tooltip-format" = "{controller_alias}\t{controller_address}";
            "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
            "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
          };

          "hyprland/language" = {
            format = "{short}";
          };

          tray = {
            "icon-size" = 16;
            spacing = 16;
          };

          idle_inhibitor = {
            format = "{icon}";
            "format-icons" = {
              activated = "\udb80\udd76";
              deactivated = "\udb83\udfaa";
            };
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
