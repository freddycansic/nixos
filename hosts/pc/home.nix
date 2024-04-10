{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../hosts/common.nix
  ];

  home.username = "freddy";
  home.homeDirectory = "/home/freddy";

  home.stateVersion = "23.11";

  home.packages = [
    pkgs.leftwm
    pkgs.polybar
    pkgs.rofi

    pkgs.nethogs
    pkgs.btop
    pkgs.zoxide
    pkgs.gradle
    pkgs.zsh-powerlevel10k
    pkgs.rustup
    pkgs.lldb
    pkgs.ripgrep
    pkgs.linuxPackages_latest.perf
    pkgs.autorandr
    pkgs.simplescreenrecorder
    pkgs.sqlite

    pkgs.discord
    pkgs.brave
    pkgs.bitwarden
    pkgs.psst
    pkgs.jetbrains.idea-ultimate
    pkgs.jetbrains.rust-rover
    pkgs.obsidian
    pkgs.gimp
    pkgs.openfortivpn
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      vadimcn.vscode-lldb
      rust-lang.rust-analyzer
    ];
  };

  programs.home-manager.enable = true;
  programs.brave.enable = true;

  programs.autorandr = {
    enable = true;
    profiles = {
      "desktop" = {
        fingerprint = {
          DP-0 = "00ffffffffffff0009d1337f455400001d1e0104a5351e783e9de1a654549f260d5054a56b80d1c081c081008180b300a9c0617c81bc023a801871382d40582c4500132a2100001e000000ff004e374c3030353535534c300a20000000fd0038901ea023000a202020202020000000fc005a4f57494520584c204c43440a01e4020319f14c010203040590111213141f4823090707830100000f3300504000373008209808132a2100001c866f80a07038404030203500132a2100001ad6530050500049400820b80c132a2100001cfe5b80a07038354030203500132a2100001afc7e80887038124018203500132a2100001e00000000000000000000000032";
        };
        config = {
          DP-0 = {
            enable = true;
            rate = "144.0";
            mode = "1920x1080";
          };
        };
      };
    };
  };

  programs.zsh = {
    enable = true;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    initExtra = ''
      source ${../../modules/zsh/p10k.zsh}
    '';
  };

  programs.git = {
    enable = true;
    userEmail = "93549743+freddycansic@users.noreply.github.com";
    userName = "Freddy Cansick";
    extraConfig = {
      init.defaultBranch = "master";
      pull.rebase = true;
      push.autoSetupRemote = true;
      commit.gpgsign = true;
      user.signingKey = "F2754989FFE3B06E";
      gpg.program = "${pkgs.gnupg}/bin/gpg";
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = false;
    enableNushellIntegration = false;
    enableBashIntegration = false;
    enableZshIntegration = true;
    options = [
      "--cmd"
      "cd"
    ];
  };

  xsession = {
    enable = true;
    initExtra = ''
      autorandr --load desktop
    '';
  };

  services.flameshot.enable = true;

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/freddy/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    XDG_RUNTIME_DIR = "/run/user/$(id -u)";
  };

  home.sessionPath = [
    "/home/freddy/.local/share/gem/ruby/3.2.0/bin"
  ];
}
