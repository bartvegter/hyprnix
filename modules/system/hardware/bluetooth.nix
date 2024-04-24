{ config, lib, pkgs, ... }:

{
  options = {
    bluetooth.enable = lib.mkEnableOption "Enables bluetooth";
  };

  config = lib.mkIf config.bluetooth.enable {

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

  };
}
