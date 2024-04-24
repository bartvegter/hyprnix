{ config, lib, pkgs, systemSettings, ... }:

{
  options = {
    networkSetup.enable = lib.mkEnableOption "Enables networkSetup";
  };

  config = lib.mkIf config.networkSetup.enable {

    networking.hostName = systemSettings.hostname;
    networking.networkmanager.enable = true;

  };
}
