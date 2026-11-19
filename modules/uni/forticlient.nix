{pkgs, ...}: let
  connect-uni-vpn = pkgs.writeShellScriptBin "connect-uni-vpn" ''
    set -euo pipefail

    read -rp "MUSE username: " USERNAME
    read -rsp "MUSE password: " PASSWORD
    echo

    exec sudo ${pkgs.openfortivpn}/bin/openfortivpn \
      remoteaccess.shef.ac.uk:443 \
      --username="$USERNAME" \
      --password="$PASSWORD"
  '';
in {
  environment.systemPackages = [pkgs.openfortivpn connect-uni-vpn];
}
