{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../modules/helix.nix
    # ../modules/hyprland.nix
    ../modules/leftwm.nix
    ../modules/kitty.nix
    ../modules/eww/eww.nix
  ];
}
