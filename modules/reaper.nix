{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.pipewire.jack
  ];

  home-manager.users.freddy = {
    home.packages = [pkgs.reaper];

    xdg.desktopEntries.cockos-reaper = {
      name = "REAPER";
      exec = "${pkgs.pipewire}/bin/pw-jack ${pkgs.reaper}/bin/reaper";
    };
  };
}
