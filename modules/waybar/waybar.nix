{
  config,
  pkgs,
  inputs,
  ...
}: {
  home-manager.users.freddy = {
    home.file.".config/waybar/platform_profile.fish".source = ./platform_profile.fish;

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

          "modules-left" = ["hyprland/workspaces" "custom/platform-profile"];
          "modules-center" = ["clock"];
          "modules-right" = ["wireplumber" "battery" "hyprland/language" "idle_inhibitor" "network" "bluetooth" "tray"];

          "hyprland/workspaces" = {
            format = "<span size='larger'>{icon}</span>";
            "on-click" = "activate";
            "format-icons" = {
              active = "\uf444";
              default = "\uf4c3";
            };
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
            format = "\udb81\udd7e  {volume}%";
            "max-volume" = 100;
            "scroll-step" = 5;
          };

          battery = {
            bat = "BAT1";
            interval = 60;
            format = "{icon}  {capacity}%";
            "format-icons" = ["\uf244" "\uf243" "\uf242" "\uf241" "\uf240"];
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

          "custom/platform-profile" = {
            format = "{icon} ";
            exec = "~/.config/waybar/platform_profile.fish";
            "return-type" = "json";
            "restart-interval" = 1;
            "format-icons" = {
              quiet = "\udb80\udf2a";
              balanced = "\udb80\ude10";
              performance = "\uf427";
              default = "?";
            };
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
            font-size: 17px;
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
