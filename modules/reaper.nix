{pkgs, ...}: let
  reaper = pkgs.reaper.overrideAttrs (old: {
    postInstall =
      (old.postInstall or "")
      + ''
        rm -f $out/share/applications/REAPER.desktop
      '';
  });

  desktopItem = pkgs.makeDesktopItem {
    name = "pw-jack reaper";
    desktopName = "REAPER";
    exec = "${pkgs.pipewire.jack}/bin/pw-jack ${reaper}/bin/reaper";
  };
in {
  environment.systemPackages = [
    pkgs.pipewire.jack
  ];

  home-manager.users.freddy = {
    home.packages = [reaper desktopItem];
  };
}
