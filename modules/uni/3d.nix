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
      pkgs.libX11
      pkgs.libXext
      pkgs.libXi
      pkgs.libXrender
      pkgs.libXfixes
      pkgs.libxcb
      pkgs.libdrm
      pkgs.mesa
    ];
  };

  environment.sessionVariables.LD_LIBRARY_PATH = [
    "${pkgs.libglvnd}/lib"
  ];
}
