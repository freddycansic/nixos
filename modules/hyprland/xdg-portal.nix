{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  home-manager.users.freddy = {
    xdg.portal = lib.mkForce {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
      xdgOpenUsePortal = true;
      configPackages = [config.programs.hyprland.package];
      config.hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.OpenURI" = "gtk";
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
        "org.freedesktop.impl.portal.Print" = "gtk";
      };
    };
  };

  services.xserver.updateDbusEnvironment = true;

  #   home.file."${config.users.users.freddy.home}/.config/systemd/user.conf".text = ''
  #     [Manager]
  #     ManagerEnvironment="XDG_DATA_DIRS=/usr/local/share:/usr/share:/home/${config.users.users.freddy.name}/.local/state/nix/profile/share:/nix/var/nix/profiles/default/share"
  #   '';
  # };
}
