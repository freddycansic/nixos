{
  pkgs,
  stdenv,
  config,
  ...
}:
stdenv.mkDerivation {
  name = "nvchad";

  src = pkgs.fetchFromGitHub {
    owner = "NvChad";
    repo = "nvchad";
    rev = "v2.5";
    sha256 = "sha256-xFd6jB+X78Y1r/ezu8WBPah+ac5oaXr1jcCAYUEwtHE=";
  };

  doBuild = false;

  installPhase = ''
    cp -r . $out
  '';
}
