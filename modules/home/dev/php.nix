{ config, lib, pkgs, ... }:

{
  options = {
    php.enable = lib.mkEnableOption "Enables php";
  };

  config = lib.mkIf config.php.enable {

    home.packages = with pkgs; [
      php
    ];

  };
}
