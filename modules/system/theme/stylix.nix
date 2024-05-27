{ config, lib, pkgs, ... }:

{
  options = {
    stylix.enable = lib.mkEnableOption "Enables stylix";
  };

  config = lib.mkIf config.stylix.enable {

    stylix = {
      autoEnable = false;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
      image = ./wallpapers/pa-mountain-cabin.png;
    };

    environment.systemPackages = with pkgs; [
      base16-schemes
    ];

  };
}
