{ config, lib, pkgs, ... }:

{
  options = {
    moduleName.enable = lib.mkEnableOption "Enables moduleName";
  };

  config = lib.mkIf config.moduleName.enable {

    #

  };
}
