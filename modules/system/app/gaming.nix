{ config, lib, pkgs, ... }:

{
  options = {
    gaming.enable = lib.mkEnableOption "Enables gaming";
  };

  config = lib.mkIf config.gaming.enable {

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
    };

    environment.systemPackages = with pkgs; [
      bottles
      lutris
      mangohud
      protonup
    ];

    programs.gamemode.enable = true;

    programs.steam = {
      enable = true;
      extest.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-run"
    ];

  };
}
