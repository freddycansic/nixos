{...}: {
  imports = [
    ./obsidian-livesync.nix
    ./prometheus.nix
  ];

  virtualisation.oci-containers = {
    backend = "podman";
  };
}
