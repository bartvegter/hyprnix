{ config, lib, pkgs, ... }:

{
  options = {
    java.enable = lib.mkEnableOption "Enables java";
  };

  config = lib.mkIf config.java.enable {

    home.packages = with pkgs; [
      jre_minimal
      zulu
    ];

  };
}
