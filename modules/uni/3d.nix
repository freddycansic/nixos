{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    pkgs.jogl

    (inputs.nix-jetbrains-plugins.lib.buildIdeWithPlugins pkgs "idea" [
      "io.github.salatmaster.direnv" # direnv
    ])
  ];
}
