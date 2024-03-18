{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../modules/helix.nix
    ../modules/hyprland.nix
    ../modules/kitty/kitty.nix
  ];
}
