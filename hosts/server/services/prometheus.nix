{ ... } :
{
  virtualisation.oci-containers = {
    containers = {
      prometheus = { 
        image = "docker.io/prom/prometheus:latest";

        ports = [
          "9090:9090"
        ];

        autoStart = true;
      };
    };
  };
}
