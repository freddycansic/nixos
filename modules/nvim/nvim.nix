{...}: {
  xdg.configFile."nvim" = {
    source = ../../modules/nvim/config;
    recursive = true;
  };
}
