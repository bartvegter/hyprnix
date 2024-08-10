{
  description = "Hyprnix config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs = { self, ... } @ inputs:
    let
      systemSettings = {
        system = "x86_64-linux";
        systemType = "hardware";
        host = "default";
        hostname = "hyprnix";
        hyprnixPath = "/home" + "/${userSettings.username}" + "/.hyprnix";
        bootMode = "uefi";
        bootMountPath = "/boot";
        grubDevice = "";
        timezone = "Europe/Amsterdam";
        language = "en_US.UTF-8";
        locale = "nl_NL.UTF-8";
        keyboardLayout = "us";
        keyboardVariant = "altgr-intl";
      };

      userSettings = {
        username = "bart";
        name = "Bart";
        email = "contact@bartvegter.com";
        shell = "zsh";
        term = "alacritty";
        editor = "nvim";
      };

      pkgs = import inputs.nixpkgs {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

      pkgs-stable = import inputs.nixpkgs-stable {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

      lib = inputs.nixpkgs.lib;

      # The following was yoinked from pjones/plasma-manager, with thanks to @LibrePhoenix on YT for referring to this.
      # Systems that can run tests:
      supportedSystems = [ "aarch64-linux" "i686-linux" "x86_64-linux" ];

      # Function to generate a set based on supported systems:
      forAllSystems = lib.genAttrs supportedSystems;

      # Attribute set of nixpkgs for each system:
      nixpkgsFor = forAllSystems (system:
        pkgs { inherit system; });
    in
    {
      nixosConfigurations = {
        ${systemSettings.hostname} = lib.nixosSystem {
          system = systemSettings.system;
          specialArgs = { inherit inputs pkgs-stable systemSettings userSettings; };
          modules = [
            ./hosts/default/configuration.nix
            inputs.stylix.nixosModules.stylix
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = { inherit inputs pkgs pkgs-stable systemSettings userSettings; };
                useGlobalPkgs = true;
                # useUserPackages = true;
                users.${userSettings.username} = import ./hosts/default/home.nix;
              };
            }
          ];
        };
      };

      homeConfigurations = {
        ${userSettings.username} = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ (./. + "/hosts" + ("/" + systemSettings.host) + "/home.nix") ];
          extraSpecialArgs = { inherit inputs pkgs-stable systemSettings userSettings; };
        };
      };

      packages = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = self.packages.${system}.install;
          install = pkgs.writeShellApplication {
            name = "install";
            runtimeInputs = with pkgs; [ git vim ];
            text = ''${./install.sh} ${systemSettings.hyprnixPath}'';
          };
        });

      apps = forAllSystems (system: {
        default = self.apps.${system}.install;
        install = {
          type = "app";
          program = "${self.packages.${system}.install}/bin/install";
        };
      });
    };
}
