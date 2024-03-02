#!/usr/bin/env bash
# A rebuild script that commits on a successful build
set -e

# cd to your config dir
pushd /home/freddy/nixos/

# Autoformat your nix files
alejandra . &>/dev/null

# Shows your changes
git diff -U0 *.nix

echo "NixOS Rebuilding..."

# Rebuild, output simplified errors, log trackebacks
nixos-rebuild switch --flake /home/freddy/nixos#default &>nixos-switch.log || (cat nixos-switch.log | grep --color error && false)

# Get current generation metadata
current=$(nixos-rebuild list-generations --flake /home/freddy/nixos#default | grep current)

# Commit all changes witih the generation metadata
git commit -am "$current"

# Back to where you were
popd

# Notify all OK!
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
