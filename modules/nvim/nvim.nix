{config, ...}: let
  nvchad = builtins.fetchGit {
    url = "https://github.com/NvChad/NvChad.git";
    rev = "6fb5c313edc966f187c7483a16affaec0518b641";
  };
in {
  home.file."~/.config/nvim" = {
    source = nvchad;
    recursive = true;
  };
}
