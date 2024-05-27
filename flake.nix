{
  description = "Hyprnix config flake";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    stylix.url = "github:danth/stylix";
  };

  outputs = { self, ... }@inputs:
    let
      systemSettings = {
        version = "unstable";
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

      userSettings = rec {
        username = "bart";
        name = "Bart";
        email = "contact@bartvegter.com";
        shell = "zsh";
        term = "alacritty";
        editor = "nvim";
      };

      home-manager = (if (systemSettings.version == "stable")
      then
        inputs.home-manager-stable
      else
        inputs.home-manager-unstable
      );

      lib = (if (systemSettings.version == "stable")
      then
        inputs.nixpkgs-stable.lib
      else
        inputs.nixpkgs-unstable.lib
      );

      pkgs-stable = import inputs.nixpkgs-stable {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

      pkgs-unstable = import inputs.nixpkgs-unstable {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

      pkgs = (if (systemSettings.version == "stable")
      then
        pkgs-stable
      else
        pkgs-unstable
      );

      pkgs-alt = (if (systemSettings.version == "stable")
      then
        pkgs-unstable
      else
        pkgs-stable
      );

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
      nixosConfigurations.${systemSettings.hostname} = lib.nixosSystem {
        system = systemSettings.system;
        modules = [
          (./. + "/hosts" + ("/" + systemSettings.host) + "/configuration.nix")
          inputs.stylix.nixosModules.stylix
        ];
        specialArgs = { inherit inputs pkgs-alt systemSettings userSettings; };
      };

      homeConfigurations.${userSettings.username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ (./. + "/hosts" + ("/" + systemSettings.host) + "/home.nix") ];
        extraSpecialArgs = { inherit inputs pkgs-alt systemSettings userSettings; };
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
            text = ''${./install.sh} "$@"'';
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
