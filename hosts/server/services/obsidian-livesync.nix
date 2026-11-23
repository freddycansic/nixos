{...}: {
  # https://www.reddit.com/r/selfhosted/comments/1eo7knj/guide_obsidian_with_free_selfhosted_instant_sync/

  virtualisation.oci-containers = {
    containers = {
      obsidian-livesync = {
        image = "docker.io/library/couchdb:latest";

        ports = [
          "5984:5984"
        ];

        volumes = [
          "/data/obsidian-livesync/data:/opt/couchdb/data"
          "/data/obsidian-livesync/etc:/opt/couchdb/etc/local.d"
        ];

        environmentFiles = [
          "/etc/obsidian-livesync.env"
        ];

        autoStart = true;

        extraOptions = [
            "--health-cmd=curl --fail -s -u :  http://localhost:5984/_up | grep -Eo '\\\"status\\\":\\\"ok\\\"' || exit 1"
            "--health-interval=30s"
            "--health-retries=3"
            "--health-timeout=10s"
            "--network-alias=obsidian-livesync"
            "--network=obsidian-livesync_default"
        ];
      };
    };
  };
}
