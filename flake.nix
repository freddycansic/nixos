{
  description = "Nixos config flake";

  inputs = {
    # Unstable packages which have been tested specifically for NixOs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Unstable packages which have been tested for Nix
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    sf-mono-nerd-font.url = "github:austinliuigi/sf-mono-nerd-font";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    nix-jetbrains-plugins.url = "github:nix-community/nix-jetbrains-plugins";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-flatpak,
    ...
  } @ inputs: {
    nixosConfigurations = let
      system = "x86_64-linux";

      common-modules = [
        inputs.home-manager.nixosModules.default
        nix-flatpak.nixosModules.nix-flatpak
      ];

      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
      };

      mkSystem = configFile:
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs pkgs-unstable;
          };

          modules = [configFile] ++ common-modules;
        };
    in {
      pc = mkSystem ./hosts/pc/configuration.nix;
      laptop = mkSystem ./hosts/laptop/configuration.nix;
    };
  };
}
