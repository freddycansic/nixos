{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    pkgs.networkmanager_dmenu
  ];

  home-manager.users.freddy = {
    xdg.configFile."networkmanager-dmenu/config.ini".source = ./config.ini;
  };
}
