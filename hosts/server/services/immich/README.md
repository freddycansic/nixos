Pull immich docker compose file as per quick start guide https://docs.immich.app/overview/quick-start/
And pull .env file

Remove DB_PASSWORD from .env file

This should be specified in the encrypted secrets.yaml file

Run this to make nix file

```bash
compose2nix -env_files .env -sops_file hosts/server/services/immich/secrets.yaml docker-compose.yml
```

Put nix file in hosts/server/services/immich/immich.nix or whatever
