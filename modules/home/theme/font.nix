{ config, lib, pkgs, ... }:

{
  options = {
    font.enable = lib.mkEnableOption "Enables fonts";
  };

  config = lib.mkIf config.font.enable {

    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      noto-fonts
      noto-fonts-lgc-plus
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };
}
