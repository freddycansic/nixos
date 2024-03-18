{pkgs, ...}: {
  home.packages = [pkgs.eww-wayland];

  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ../../modules/eww;
  };
}
