{ config, lib, pkgs, ... }:

{
  options = {
    steam.enable = lib.mkEnableOption "Enables steam";
  };

  config = lib.mkIf config.steam.enable {

    programs.steam = {
      enable = true;
      extest.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession = {
        enable = false;
        # env = {};
        # args = [];
      };
    };

  };
}
