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

nh os switch . -H $host

if test $status -ne 0
    echo "Failed to rebuild"
    exit 1
end

set info (nh os info | grep current)
set timestamp (echo $info | cut -d' ' -f5-6 | string trim) # timestamp
set metadata (echo $info | cut -d' ' -f7- | string trim) # nix version, kernel version

echo "Enter optional commit message (press Enter to skip):"
read -l description

if test -n "$description"
    set message "$timestamp - $description"\n\n"$metadata"
else
    set message "$timestamp"\n\n"$metadata"
end

git add .
git commit -m "$message"

# Back to where you were
popd

# Notify success
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
