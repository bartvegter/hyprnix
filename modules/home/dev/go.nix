{ config, lib, pkgs, ... }:

{
  options = {
    go.enable = lib.mkEnableOption "Enables go";
  };

  config = lib.mkIf config.go.enable {

    home.packages = with pkgs; [
      go
    ];

  };
}
