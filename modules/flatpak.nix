{...}: {
  services.flatpak = {
    enable = true;
    packages = [
      "com.spotify.Client"
    ];
  };

  home-manager.users.freddy = {
    # add flatpak programs to path
    home.file.".profile".text = ''
      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share/applications:$HOME/.local/share/flatpak/exports/share/applications"
    '';
  };
}
