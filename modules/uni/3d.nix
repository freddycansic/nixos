{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.jogl
    pkgs.intellij-idea
  ];
}
