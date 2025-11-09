{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    pkgs.libnotify # depdendency for notification daemons
  ];

  home-manager.users.freddy = {
    services.mako = {
      enable = true;
      settings = {
        default-timeout = 5 * 1000;
      };
    };
  };
}
