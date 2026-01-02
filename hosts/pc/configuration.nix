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
    secureBoot.enable = true;
    extraEntries = ''
      /Windows
          protocol: efi
          path: uuid(a116eb84-3cfe-419a-89d8-c14761aeed9d):/EFI/Microsoft/Boot/bootx64.efi
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
