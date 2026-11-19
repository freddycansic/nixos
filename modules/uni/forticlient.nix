{pkgs, ...}: let
  connect-uni-vpn = pkgs.writeShellApplication {
    name = "connect-uni-vpn";
    text = ''
      exec sudo ${pkgs.openconnect}/bin/openconnect \
        --protocol=fortinet \
        remoteaccess.shef.ac.uk
    '';
  };
in {
  environment.systemPackages = [pkgs.openconnect connect-uni-vpn];
}
