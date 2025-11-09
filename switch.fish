#!/usr/bin/env fish

# Rebuild script that commits on a successful build

if test (count $argv) -eq 0
    echo "Usage: $0 <host>"
    exit 1
end
set host $argv[1]

pushd /home/freddy/nixos/

# Autoformat nix files
alejandra . &>/dev/null
if test $status -ne 0
    alejandra .
    echo "formatting failed!"
    exit 1
end

echo "Enter optional commit message (press Enter to skip):"
read -l description

nh os switch . -H $host

if test $status -ne 0
    echo "Failed to rebuild"
    exit 1
end

set info (nh os info | grep current)
set message (echo $info | cut -d' ' -f1) # just the generation
set metadata (echo $info | cut -d' ' -f3- | string trim) # timestamp, nix version, kernel version

if test -n "$description"
    set message "$message - $description"\n\n"$metadata"
end

git commit -am "$message"

# Back to where you were
popd

# Notify success
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
