{ config, lib, pkgs, ... }:

{
  options = {
    sddm.enable = lib.mkEnableOption "Enables SDDM";
  };

  config = lib.mkIf config.sddm.enable {

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "chili";
    };

    environment.systemPackages = with pkgs; [
      (sddm-chili-theme.override {
        themeConfig = {
          background = config.stylix.image;
          ScreenWidth = 2560;
          ScreenHeight = 1440;
          blur = true;
          recursiveBlurLoops = 4;
          recursiveBlurRadius = 15;
        };
      })
    ];

  };
}
