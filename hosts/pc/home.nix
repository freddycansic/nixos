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
    pkgs.swww
    pkgs.rofi-wayland

    pkgs.wlsunset

    pkgs.nethogs
    pkgs.btop
    pkgs.zoxide
    pkgs.gradle
    pkgs.zsh-powerlevel10k
    pkgs.rustup
    pkgs.lldb

    pkgs.discord
    pkgs.brave
    pkgs.bitwarden
    pkgs.psst
    pkgs.jetbrains.idea-ultimate
    pkgs.jetbrains.rust-rover
    pkgs.obsidian
    pkgs.gimp
    # pkgs.vscode
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
    ];
  };

  programs.home-manager.enable = true;
  programs.brave.enable = true;

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
      source ${../../modules/zsh/.p10k.zsh}
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

  services.wlsunset = {
    enable = true;
    latitude = "52.2";
    longitude = "-1.2";
  };

  services.flameshot.enable = true;

  xdg.desktopEntries.obsidian = {
    name = "Obsidian";
    exec = "obsidian --disable-gpu";
  };

  xdg.desktopEntries.vscode = {
    name = "VSCode";
    exec = "env -u WAYLAND_DISPLAY vscodium";
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    # ".p10k.zsh".source = ../../modules/zsh/.p10k.zsh;
  };

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
