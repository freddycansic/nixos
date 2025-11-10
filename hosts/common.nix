{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../modules/hyprland/hyprland.nix
    ../modules/fish/fish.nix
    ../modules/zed.nix
    ../modules/networkmanager-dmenu/networkmanager-dmenu.nix
  ];

  environment.systemPackages = [
    pkgs.alejandra # nix formatter
    pkgs.psmisc # includes killall
    pkgs.nixd # nix language server
  ];

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    inputs.sf-mono-nerd-font.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
      user = {
        name = "Freddy Cansick";
        email = "93549743+freddycansic@users.noreply.github.com";
      };
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };

  home-manager.users.freddy = {
    home.packages = [
      pkgs.brave
      pkgs.meld
      pkgs.bitwarden-desktop
    ];

    programs.vim = {
      enable = true;
    };

    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 4d --keep 3";
      };
    };

    programs.zed-editor = {
      enable = true;
    };

    programs.fd.enable = true;

    programs.fzf.enable = true;

    programs.alacritty = {
      enable = true;
      theme = "one_dark";
      settings = {
        window = {
          padding = {
            x = 3;
            y = 3;
          };
        };
      };
    };

    programs.fastfetch = {
      enable = true;
      settings = {
        "modules" = [
          "title"
          "separator"
          "os"
          "host"
          "kernel"
          "uptime"
          # "packages"
          "shell"
          "display"
          "de"
          "wm"
          "wmtheme"
          # "theme"
          # "icons"
          # "font"
          # "cursor"
          "terminal"
          # "terminalfont"
          "cpu"
          "gpu"
          "memory"
          "swap"
          "disk"
          # "localip"
          "battery"
          "poweradapter"
          {
            "type" = "colors";
            "symbol" = "square";
          }
        ];
      };
    };
  };
}
