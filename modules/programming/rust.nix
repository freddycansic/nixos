{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    (inputs.nix-jetbrains-plugins.lib.buildIdeWithPlugins pkgs "rust-rover" [
      "io.github.salatmaster.direnv" # direnv
      "nix-idea" # nix
      "GLSL"
    ])
  ];
}
