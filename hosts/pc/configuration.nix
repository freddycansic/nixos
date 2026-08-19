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
    ../../modules/gaming/minecraft.nix
    ../../modules/gaming/steam.nix
  ];

  environment.systemPackages = [
    pkgs.blender
  ];

  services.xserver = {
    enable = true;
    xkb = {
      layout = lib.mkForce "us";
      variant = "";
    };
    videoDrivers = ["amdgpu"];
  };

  hyprland = {
    enable = true;
    kb_layout = "us";
    monitor = {
      output = "DP-2";
      mode = "1920x1080@144";
      position = "0x0";
      scale = 1.0;
    };
    sensitivity = -0.7;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "freddy" = import ./home.nix;
    };
  };
}
