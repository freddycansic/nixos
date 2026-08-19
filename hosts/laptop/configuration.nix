# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ../common/system.nix
    ./hardware-configuration.nix
  ];

  environment.systemPackages = [
    pkgs.brightnessctl
  ];

  hyprland = {
    enable = true;
    kb_layout = "gb";
    monitor = {
      output = "eDP-1";
      mode = "1920x1080@60";
      position = "0x0";
      scale = 1.0;
    };
    sensitivity = 0.0;
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16 gb
    }
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "freddy" = import ./home.nix;
    };
  };
}
