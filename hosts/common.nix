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
  ];

  environment.systemPackages = [
    pkgs.alejandra # nix formatter
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
      push = {autoSetupRemote = true;};
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

    programs.alacritty.enable = true;

    programs.kitty.enable = true;
  };
}
