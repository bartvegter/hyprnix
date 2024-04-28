{ config, lib, pkgs, ... }:

{
  options = {
    python.enable = lib.mkEnableOption "Enables python";
  };

  config = lib.mkIf config.python.enable {

    home.packages = with pkgs; [
      python3
    ];

  };
}
