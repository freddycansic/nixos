{...}: {
  imports = [./docker-compose.nix];

  services.tailscale = {
    serve.services.immich = {
      endpoints = {
        "tcp:2283" = "http://127.0.0.1:2283";
      };
    };
  };

  sops.secrets."immich-secrets" = {
    sopsFile = ./secrets.yaml;
    format = "yaml";
    key = "immich-secrets";
  };
}
