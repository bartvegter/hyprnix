{ config, lib, ... }:

{
  options = {
    corectrl.enable = lib.mkEnableOption "Enables corectrl";
  };

  config = lib.mkIf config.corectrl.enable {

    programs.corectrl = {
      enable = true;
      gpuOverclock.enable = false;
    };

  };
}
