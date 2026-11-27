{pkgs, ...}: let
  tikz-editor = pkgs.callPackage ./derivation.nix {};
in {
  environment.systemPackages = [tikz-editor];
}
