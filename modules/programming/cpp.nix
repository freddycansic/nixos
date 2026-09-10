{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.cmake
    pkgs.clang
    pkgs.ninja
    pkgs.pkg-config
  ];
}
