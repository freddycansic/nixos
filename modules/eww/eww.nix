{config, ...}: {
  home.file = {
    "${config.xdg.configHome}/eww" = {
      source = ../../modules/eww;
      recursive = true;
    };
  };
}
