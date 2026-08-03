{
  config,
  pkgs,
  inputs,
  system,
  ...
}: {
  imports = [
    ../../modules/fish/fish.nix
    ../../modules/zed.nix
    ../../modules/hyprland/hyprland.nix
    ../../modules/flatpak.nix
  ];

  environment.systemPackages = [
    pkgs.alejandra # nix formatter
    pkgs.psmisc # includes killall
    pkgs.nixd # nix language server
    pkgs.tree
    # pkgs.kdePackages.xwaylandvideobridge
    pkgs.discord
    pkgs.pinta # paint.net on linux
    pkgs.pavucontrol
    pkgs.sbctl # cli tool for secureboot
    pkgs.mesa-demos # opengl examples for testing
    pkgs.nwg-look # theme options editor
    pkgs.renderdoc
    pkgs.sourcegit
    pkgs.ripgrep
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.rust-rover [
      inputs.nix-jetbrains-plugins.plugins."${pkgs.stdenv.hostPlatform.system}".rust-rover."2025.3"."systems.fehn.intellijdirenv" # direnv
      inputs.nix-jetbrains-plugins.plugins."${pkgs.stdenv.hostPlatform.system}".rust-rover."2025.3"."nix-idea" # nix
      inputs.nix-jetbrains-plugins.plugins."${pkgs.stdenv.hostPlatform.system}".rust-rover."2025.3"."OpenGL-Plugin" # glsl
    ])
    pkgs.vlc
    pkgs.wl-clipboard # cmdline clipboard utils
    pkgs.pinentry-gtk2 # password entering utility for gnupg
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
    pinentryPackage = pkgs.pinentry-gtk2;
    enableSSHSupport = true;
  };

  services.tailscale.enable = true;

  # https://github.com/NixOS/nixpkgs/issues/526914 bitwarden depends on EOL electron
  # FIXME https://github.com/NixOS/nixpkgs/pull/545058
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];

  nixpkgs.overlays = [
    (final: prev: {
      bitwarden-desktop = prev.bitwarden-desktop.override {
        electron_39 = final.electron_39-bin;
      };
    })
  ];

  home-manager.users.freddy = {
    services.cliphist = {
      enable = true;
      systemdTargets = [
        "config.wayland.systemd.target"
      ];
      allowImages = true;
    };

    home.packages = [
      pkgs.brave
      pkgs.meld
      pkgs.bitwarden-desktop
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
