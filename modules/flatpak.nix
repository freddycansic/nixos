{
  config,
  pkgs,
  inputs,
  ...
}: {
  # services.flatpak.enable = true;
  # systemd.services.flatpak-repo = {
  #   wantedBy = ["multi-user.target"];
  #   path = [pkgs.flatpak];
  #   script = ''
  #     flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  #   '';
  # };

  services.flatpak.packages = [
    "com.spotify.Client"
  ];

  home-manager.users.freddy = {
    # add flatpak to path
    home.file.".profile".text = ''
      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"
    '';

    xdg.desktopEntries.spotify-flatpak = {
      name = "Spotify";
      genericName = "Music Player";
      exec = "flatpak run com.spotify.Client";
      icon = "com.spotify.Client";
      terminal = false;
      categories = ["Audio" "Music" "Player"];
    };
  };
}
