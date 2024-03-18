{pkgs, ...}: {
  home.packages = [pkgs.eww-wayland];

  # programs.eww-wayland = {
  # enable = true;
  # configDir = ../../modules/eww;
  # };
}
