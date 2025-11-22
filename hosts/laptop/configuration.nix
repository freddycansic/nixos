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
    ../common-system.nix
    ./hardware-configuration.nix
  ];

  environment.systemPackages = [
    pkgs.brightnessctl
  ];

  hyprland = {
    enable = true;
    kb_layout = "gb";
    monitor = "eDP-1, 1920x1080@60, 0x0, 1";
    sensitivity = 0.0;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "freddy" = import ./home.nix;
    };
  };
}
