{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    sf-mono-nerd-font.url = "github:austinliuigi/sf-mono-nerd-font";

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = {
    self,
    nixpkgs,
    nix-flatpak,
    ...
  } @ inputs: {
    nixosConfigurations = let
      common-modules = [inputs.home-manager.nixosModules.default nix-flatpak.nixosModules.nix-flatpak];
    in {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules =
          [
            ./hosts/laptop/configuration.nix
          ]
          ++ common-modules;
      };

      pc = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules =
          [
            ./hosts/pc/configuration.nix
          ]
          ++ common-modules;
      };
    };
  };
}
