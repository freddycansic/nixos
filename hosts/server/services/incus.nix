{...}: {
  virtualisation.incus.enable = true;
  networking.nftables.enable = true;

  users.users.freddy.extraGroups = ["incus-admin"];
}
