#!/usr/bin/env fish

# Rebuild script that commits on a successful build

if test (count $argv) -eq 0
    echo "Usage: $0 <host>"
    exit 1
end

set host $argv[1]

# cd to your config dir
pushd ~/nixos/

# Early return if no changes detected
git diff --quiet
if test $status -eq 0
    echo "No changes detected, exiting."
    popd
    exit 0
end

# Autoformat nix files
set alejandra_output (alejandra . ^&1) # capture both stderr and stdout
if test $status -ne 0
    echo $alejandra_output
    echo "formatting failed!"
    exit 1
end

echo "NixOS Rebuilding..."

nh os switch . -H $host --diff auto

if test $status -ne 0
    echo "Failed to rebuild"
    exit 1
end

# Get current generation metadata
set info (nh os info | grep current)
set info (echo $info | sed -e 's/[[:space:]]*$//') # trim trailing whitespace
set info (echo $info | sed 's/(current)//') # remove "(current)"
set current (echo $info | sed 's/[[:space:]]\+/ - /g') # replace whitespace with " - "

# Commit changes with generation metadata
git commit -am "$current"

# Back to where you were
popd

# Notify success
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
