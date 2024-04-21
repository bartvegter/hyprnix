{ config, pkgs, ... }:

{
  # Makes fonts installed in home.nix discoverable
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-lgc-plus
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
