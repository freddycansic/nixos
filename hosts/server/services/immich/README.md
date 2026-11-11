Pull immich docker compose file as per quick start guide https://docs.immich.app/overview/quick-start/
And pull .env file

Remove DB_PASSWORD from .env file

This should be specified in the encrypted secrets.yaml file

Edit docker-compose.yml and add
```yaml
labels:
    - "compose2nix.settings.sops.secrets=immich-secrets"
```
to each container that needs database

Run this to make nix file

```bash
compose2nix -env_files .env -sops_file hosts/server/services/immich/secrets.yaml docker-compose.yml
```

Put nix file in hosts/server/services/immich/immich.nix or whatever
