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
      # System settings
      systemSettings = {
        arch = "x86_64-linux";
        hostname = "hyprnix";
        timezone = "Europe/Amsterdam";
        language = "en_US.UTF-8";
        locale = "nl_NL.UTF-8";
        keyboardLayout = "us";
        keyboardVariant = "altgr-intl";
      };

      # User settings
      userSettings = rec {
        username = "bart";
        name = "Bart";
        email = "contact@bartvegter.com";
        term = "alacritty";
        editor = "nvim";
      };

      # Library & Package settings
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${systemSettings.arch};
      lib-stable = nixpkgs-stable.lib;
      pkgs-stable = nixpkgs-stable.legacyPackages.${systemSettings.arch};

    in
    {
      nixosConfigurations = {
        hyprnix = lib.nixosSystem {
          inherit ${systemSettings.arch};
          modules = [ ./configuration.nix ];
          specialArgs = {
            inherit pkgs-stable;
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };

      homeConfigurations = {
        bart = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
          extraSpecialArgs = {
            inherit pkgs-stable;
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };
    };
}
