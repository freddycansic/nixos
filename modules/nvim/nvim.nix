{
  config,
  pkgs,
  ...
}: {
  xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
    owner = "NvChad";
    repo = "NvChad";
    rev = "6fb5c313edc966f187c7483a16affaec0518b641";
    sha256 = "sha256-U81M3RFMP7jKirxj3ROCsyqTRXGCrtN6VsPrewlPSLI=";
  };
}
