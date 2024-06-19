{ config, lib, pkgs, ... }:

{
  options = {
    devenv.enable = lib.mkEnableOption "Enables devenv";
  };

  config = lib.mkIf config.devenv.enable {

    home.packages = with pkgs; [
      vscodium
    ];

  };
}
