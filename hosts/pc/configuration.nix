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
    pkgs.blender
  ];

  boot.loader = {
    systemd-boot.enable = false;

    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      enableCryptodisk = false;
    };
  };

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
    monitor = "DP-2, 1920x1080@144, 0x0, 1";
    sensitivity = -0.7;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "freddy" = import ./home.nix;
    };
  };
}
