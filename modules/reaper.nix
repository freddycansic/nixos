{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.pipewire.jack
  ];

  home-manager.users.freddy = {
    home.packages = [pkgs.reaper];

    xdg.desktopEntries."REAPER" = {
      name = "Reaper";
      exec = "${pkgs.pipewire}/bin/pw-jack ${pkgs.reaper}/bin/reaper";
      terminal = false;
      type = "Application";
    };
  };
}
