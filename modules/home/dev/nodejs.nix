{ config, lib, pkgs, ... }:

{
  options = {
    nodejs.enable = lib.mkEnableOption "Enables nodejs";
  };

  config = lib.mkIf config.nodejs.enable {

    home.packages = with pkgs; [
      nodejs_21
    ];

  };
}
