{...}: {
  imports = [
    ./obsidian-livesync.nix
    ./prometheus.nix
    ./immich/immich.nix
  ];

  virtualisation.oci-containers = {
    backend = "podman";
  };
}
