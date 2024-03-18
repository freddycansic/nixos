{pkgs, ...}: {
  home.packages = [pkgs.eww-wayland];

  programs.eww = {
    enable = true;
    configDir = ../../modules/eww;
  };
}
