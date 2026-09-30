{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.jogl
    pkgs.intellij-idea
  ];

  programs.nix-ld = {
    enable = true;
    libraries = [
      pkgs.libGL
      pkgs.xorg.libXxf86vm
    ];
  };
}
