{...}: {
  services.flatpak = {
    enable = true;
    packages = [
      "com.spotify.Client"
    ];
  };

  home-manager.users.freddy = {
    # index flatpak .desktop files
    home.sessionVariables = {
      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports";
    };
  };
}
