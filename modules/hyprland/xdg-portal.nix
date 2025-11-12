{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  services.xserver.updateDbusEnvironment = true;

  home-manager.users.freddy = {
    home.file."${config.users.users.freddy.home}/.config/systemd/user.conf".text = ''
      [Manager]
      ManagerEnvironment="XDG_DATA_DIRS=/usr/local/share:/usr/share:/home/${config.users.users.freddy.name}/.local/state/nix/profile/share:/nix/var/nix/profiles/default/share"
    '';
  };
}
