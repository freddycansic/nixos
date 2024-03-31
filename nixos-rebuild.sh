#!/usr/bin/env bash
# A rebuild script that commits on a successful build

set -e

# cd to your config dir
pushd /home/freddy/nixos/

# Autoformat your nix files
alejandra_output=$(sudo alejandra . 2>&1)

if [ $? -ne 0 ]; then
  echo $alejandra_output
fi

# Shows your changes
git diff -U0 **/*.nix
git add .

echo "NixOS Rebuilding..."

# Rebuild, output simplified errors, log trackebacks
sudo nixos-rebuild switch --flake .
# Get current generation metadata
current=$(nixos-rebuild list-generations --flake . | grep current | sed 's/\*$//')

# Commit all changes witih the generation metadata
git commit -am "$current"

# Back to where you were
popd

# Notify all OK!
notify-send -e "NixOS Rebuilt OK!" -t 3000 --icon=software-update-available
