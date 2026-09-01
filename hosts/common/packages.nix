{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  system,
  ...
}: {
  imports = [
    ../../modules/fish/fish.nix
    ../../modules/zed.nix
    ../../modules/hyprland/hyprland.nix
    ../../modules/flatpak.nix
    ../../modules/rust.nix
    ../../modules/reaper.nix
  ];

  environment.systemPackages = [
    pkgs.alejandra # nix formatter
    pkgs.psmisc # includes killall
    pkgs.nixd # nix language server
    pkgs.tree
    pkgs.discord
    pkgs.pinta # paint.net on linux
    pkgs.sbctl # cli tool for secureboot
    pkgs.mesa-demos # opengl examples for testing
    pkgs.nwg-look # theme options editor
    pkgs.renderdoc
    pkgs.sourcegit
    pkgs.ripgrep
    pkgs.vlc
    pkgs.wl-clipboard # cmdline clipboard utils
    pkgs.pinentry-gnome3 # password entering utility for gnupg
    pkgs.efibootmgr # boot manager utility
    pkgs.unzip
    pkgs.wlprop # xprop for wayland
    pkgs.btop
    pkgs.obsidian
    pkgs.obsidian # with plugins: git, spaced repetition, quickadd
    pkgs.arp-scan # scan local network
    pkgs.qt6.qtwayland
    pkgs.krita # drawing app
    pkgs.dig # dns utility
    pkgs.brightnessctl # manage screen brightness
    pkgs-unstable.godot # TODO FIXME at the time, there was a bug in 4.7.1 which made godot crash when editing tilemaps
    # it was fixed in 4.7.2 which was not available on nixos-unstable, but was on nixpkgs-unstable
  ];

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    inputs.sf-mono-nerd-font.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      wayland
    ];
  };

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

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    enableSSHSupport = true;
  };

  services.tailscale.enable = true;

  home-manager.users.freddy = {
    services.cliphist = {
      enable = true;
      systemdTargets = [
        "config.wayland.systemd.target"
      ];
      allowImages = true;
    };

    home.packages = [
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.meld
      pkgs.bitwarden-desktop
      pkgs.aseprite
    ];

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

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      # enableFishIntegration = true; # happens automatically
      config = {
        warn_timeout = "1m";
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

    programs.fd.enable = true;

    programs.fzf.enable = true;

    programs.ncspot.enable = true;

    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 4d --keep 3";
      };
    };

    programs.vim = {
      enable = true;
    };

    programs.zed-editor = {
      enable = true;
    };
  };
}
