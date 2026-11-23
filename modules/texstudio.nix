{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.texstudio
    (pkgs.texliveSmall.withPackages (ps: [
      ps.biblatex
      ps.biber
      ps.pgfgantt
      ps.adjustbox
      ps.hyphenat
      ps.appendix
      ps.circuitikz
      ps.pgfplots
    ]))
  ];
}
