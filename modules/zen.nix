{
  inputs,
  pkgs,
  ...
}: {
  home-manager.users.freddy = {
    home.packages = [
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
