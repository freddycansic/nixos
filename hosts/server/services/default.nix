{...}: {
  imports = [
    ./obsidian-livesync.nix
    ./prometheus.nix
    ./immich.nix
  ];

  virtualisation.oci-containers = {
    backend = "podman";
  };
}
