{
  pkgs,
  stdenv,
  ...
}: let
  nvchad = pkgs.callPackage ./nvchad.nix {};
in {
  xdg.configFile."nvim".source = nvchad;
}
