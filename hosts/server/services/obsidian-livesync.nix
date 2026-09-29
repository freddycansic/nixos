{...}: {
  virtualisation.oci-containers = {
    backend = "podman";

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

        environment = {
          COUCHDB_USER = "obsidian_user";
          COUCHDB_PASSWORD = "CHANGE_ME";
        };

        autoStart = true;
      };
    };
  };
}
