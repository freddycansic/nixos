{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.kitty];

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    extraConfig = "
      enabled_layouts tall
      confirm_os_window_close 0
    ";
    font = {
      name = "firacode";
      size = 11;
    };
    theme = "Gruvbox Dark";
  };
}
