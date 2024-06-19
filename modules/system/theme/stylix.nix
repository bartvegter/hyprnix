{ config, lib, pkgs, ... }:

{
  options = {
    stylixConfig.enable = lib.mkEnableOption "Enables stylix";
  };

  config = lib.mkIf config.stylixConfig.enable {

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
      image = ../../home/theme/wallpapers/far_from_tomorrow_4k.png;

      cursor = {
        package = pkgs.whitesur-cursors;
        name = "WhiteSur-cursors";
        size = 24;
      };

      fonts = {
        # packages = with pkgs; [
        #   noto-fonts
        #   noto-fonts-lgc-plus
        #   noto-fonts-cjk-serif
        #   noto-fonts-color-emoji
        #   (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        # ];
        monospace = {
          package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
          name = "JetBrainsMono NF";
        };
        sansSerif = {
          package = pkgs.noto-fonts;
          name = "Noto Sans";
        };
        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
        sizes = {
          applications = 11;
          desktop = 10;
          popups = 10;
          terminal = 11;
        };
      };

      autoEnable = true;
      targets = {
        chromium.enable = false;
      };
    };

    environment.systemPackages = with pkgs; [
      base16-schemes
      noto-fonts-lgc-plus
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

  };
}
