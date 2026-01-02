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

  boot.loader.limine = {
    enable = true;
    secureBoot.enable = false;
    extraEntries = ''
      /Windows
          protocol: efi
          path: uuid(19f4fa70-d949-481e-8a35-e46a8a6e1158):/EFI/Microsoft/Boot/bootmgfw.efi
    '';
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
