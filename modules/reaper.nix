{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.pipewire.jack
  ];

  home-manager.users.freddy = {
    home.packages = [pkgs.reaper];

    xdg.desktopEntries.jeff-reaper = {
      name = "REAPER";
      exec = "${pkgs.pipewire.jack}/bin/pw-jack ${pkgs.reaper}/bin/reaper";
    };
  };
}
