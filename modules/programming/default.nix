{pkgs, ...}: {
  imports = [
    ./cpp.nix
    ./rust.nix
  ];

  environment.systemPackages = [
    pkgs.wayland
    pkgs.wayland-protocols
  ];
}
