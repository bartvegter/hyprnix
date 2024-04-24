{ config, lib, pkgs, ... }:

{
  options = {
    gamemode.enable = lib.mkEnableOption "Enables gamemode";
  };

  config = lib.mkIf config.gamemode.enable {

    programs.gamemode.enable = true;

  };
}
