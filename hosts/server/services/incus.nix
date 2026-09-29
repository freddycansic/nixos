{...}: {
  virtualisation.incus = {
    enable = true;
    ui.enable = true;

    preseed.config = {
      "core.https_address" = "8443";
    };
  };

  networking.nftables.enable = true;

  users.users.freddy.extraGroups = ["incus-admin"];

  networking.firewall.allowedTCPPorts = [8443];

  networking.firewall.interfaces.incusbr0.allowedTCPPorts = [
    53
    67
  ];

  networking.firewall.interfaces.incusbr0.allowedUDPPorts = [
    53
    67
  ];
}
