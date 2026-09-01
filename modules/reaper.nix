{pkgs, ...}: let
  reaper-no-desktop = pkgs.symlinkJoin {
    name = "reaper-no-desktop";
    paths = [pkgs.reaper];
    postBuild = ''
      rm -rf $out/share/applications
    '';
  };
in {
  environment.systemPackages = [
    pkgs.pipewire.jack
  ];

  home-manager.users.freddy = {
    home.packages = [reaper-no-desktop];

    xdg.desktopEntries.cockos-reaper = {
      name = "REAPER";
      exec = "${pkgs.pipewire.jack}/bin/pw-jack ${reaper-no-desktop}/bin/reaper";
    };
  };
}
