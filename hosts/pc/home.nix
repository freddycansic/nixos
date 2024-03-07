{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../hosts/common.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "freddy";
  home.homeDirectory = "/home/freddy";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.discord
    pkgs.brave
    pkgs.kitty
    pkgs.bitwarden
    pkgs.psst
    pkgs.zoxide
    pkgs.nethogs
    pkgs.jetbrains.idea-ultimate
    pkgs.gradle
    pkgs.gammastep
  ];

  programs.home-manager.enable = true;
  programs.brave.enable = true;
  programs.zsh.enable = true;

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    extraConfig = "
      enabled_layouts tall
      confirm_os_window_close 0
    ";
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

  services.gammastep = {
    enable = true;
    latitude = 52.219223;
    longitude = -1.19701;
    tray = true;
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
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, P, exec, rofi -show run"
        "$mod, Return, exec, kitty"
        "$mod, Q, killactive"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;
      };

      monitor = "DP-2,1920x1080@144,0x0,1";

      windowrulev2 = [
        "noanim,floating:1,class:^(jetbrains-.*),title:^(win\\d+)"
        "noinitialfocus,floating:1,class:^(jetbrains-.*),title:^(win\\d+)"
      ];
    };
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
}
