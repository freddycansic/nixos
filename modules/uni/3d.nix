{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.jogl
    pkgs.intellij-idea
  ];

  programs.nix-ld = {
    enable = true;
    libraries = [
      pkgs.libGL
      pkgs.libXxf86vm
      pkgs.jogl
    ];
  };
}
