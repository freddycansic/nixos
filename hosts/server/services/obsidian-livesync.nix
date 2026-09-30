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
      };
    };
  };
}
