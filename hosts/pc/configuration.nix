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

  hyprland = {
    enable = true;
    kb_layout = "us";
    monitor = "DP-2, 1920x1080@144, 0x0, 1";
  };

  services.xserver.xkb = lib.mkForce {
    layout = "us";
    variant = "";
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "freddy" = import ./home.nix;
    };
  };
}
