{
  description = "Hyprnix config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs = { self, ... }@inputs:
    let
      # System settings
      systemSettings = {
        version = "unstable";
        system = "x86_64-linux";
        hostname = "hyprnix";
        dotfilesPath = "~/.hyprnix";
        bootMode = "uefi";
        bootMountPath = "/boot";
        grubDevice = "";
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
        shell = "zsh";
        term = "alacritty";
        editor = "nvim";
      };

      # Library & Package definitions
      lib = (if (systemSettings.version == "stable")
      then
        inputs.nixpkgs-stable.lib
      else
        inputs.nixpkgs.lib
      );

      home-manager = (if (systemSettings.version == "stable")
      then
        inputs.home-manager-stable
      else
        inputs.home-manager
      );

      pkgs = (if (systemSettings.version == "stable")
      then
        pkgs-stable
      else
        (import inputs.nixpkgs {
          system = systemSettings.system;
          config = {
            allowUnfree = true;
            allowUnfreePredicate = (_: true);
          };
        })
      );

      pkgs-stable = import inputs.nixpkgs-stable {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };


      # The following was yoinked from pjones/plasma-manager, with thanks to @LibrePhoenix on YT for referring to this.
      # Systems that can run tests:
      supportedSystems = [ "aarch64-linux" "i686-linux" "x86_64-linux" ];

      # Function to generate a set based on supported systems:
      forAllSystems = lib.genAttrs supportedSystems;

      # Attribute set of nixpkgs for each system:
      nixpkgsFor = forAllSystems (system:
        import inputs.nixpkgs { inherit system; });
    in
    {
      nixosConfigurations = {
        system = lib.nixosSystem {
          system = systemSettings.system;
          modules = [ ./system/configuration.nix ];
          specialArgs = {
            inherit pkgs-stable;
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };

      homeConfigurations = {
        user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./user/home.nix ];
          extraSpecialArgs = {
            inherit pkgs-stable;
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };

      packages = forAllSystems (system:
        let pkgs = nixpkgsFor.${system};
        in
        {
          default = self.packages.${system}.install;

          install = pkgs.writeShellApplication {
            name = "install";
            runtimeInputs = with pkgs; [ git ]; # I could make this fancier by adding other deps
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
