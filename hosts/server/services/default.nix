{...}: {
  imports = [
    ./obsidian-livesync.nix
  ];

  virtualisation.oci-containers = {
    backend = "podman";
  };
}
