{...}: {
  services.cockpit.enable = true;

  # Default port for cockpit web ui
  networking.firewall.allowedTCPPorts = [9090];
}
