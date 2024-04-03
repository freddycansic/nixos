{...}: {
  home.file.".config/nvim" = {
    source = ../../modules/nvim/config;
    recursive = true;
  };
}
