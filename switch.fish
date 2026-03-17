#!/usr/bin/env fish

# Rebuild script that commits on a successful build

set machine_id (cat /etc/machine-id)

switch $machine_id
    case "dc1082ffd8ac44c99b9d83101c3cd51f"
        set host pc
    case '*'
        echo "Unknown machine-id: $machine_id"
        exit 1
end

echo "On host: $host"

pushd /home/freddy/nixos/

# nix won't recognise files which aren't added to the git repo
git add .

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
