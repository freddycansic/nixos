{pkgs, ...}: let
  desktopItem = pkgs.makeDesktopItem {
    name = "pw-jack reaper";
    desktopName = "Reaper";
    exec = "${pkgs.pipewire.jack} ${pkgs.reaper}";
  };
in {
  environment.systemPackages = [
    pkgs.pipewire.jack
  ];

  home-manager.users.freddy = {
    home.packages = [pkgs.reaper desktopItem];
  };
}
