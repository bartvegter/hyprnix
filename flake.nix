{
  description = "Hyprnix config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      lib-stable = nixpkgs-stable.lib;
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};

      hostname = "hyprnix";
      username = "bart";
      name = "Bart";
    in
    {
      nixosConfigurations = {
        hyprnix = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
          specialArgs = {
            inherit hostname;
            inherit username;
            inherit name;
            inherit pkgs-stable;
          };
        };
      };

      homeConfigurations = {
        bart = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
          extraSpecialArgs = {
            inherit hostname;
            inherit username;
            inherit name;
            inherit pkgs-stable;
          };
        };
      };
    };
}
