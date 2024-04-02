{...}: {
  home.file.".config/nvim" = builtins.fetchGit {
    url = "https://github.com/NvChad/NvChad.git";
    ref = "master";
  };
}
