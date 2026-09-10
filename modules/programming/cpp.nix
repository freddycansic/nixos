{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.cmake
    pkgs.clang
  ];
}
