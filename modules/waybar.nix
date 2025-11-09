{
  config,
  pkgs,
  inputs,
  ...
}: {
  home-manager.users.freddy = {
    programs.waybar = {
      enable = true;
      systemd.enableDebug = true;
    };
  };
}
