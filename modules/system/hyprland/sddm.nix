{ config, lib, pkgs, userSettings, ... }:

{
  options = {
    sddm.enable = lib.mkEnableOption "Enables SDDM";
  };

  config = lib.mkIf config.sddm.enable {

    environment.systemPackages = with pkgs; [
      (sddm-chili-theme.override {
        themeConfig = {
          # background = "/home" + ("/" + "${userSettings.username}") + "/.config/hypr/wallpapers/pa-mountain-cabin.jpg";
          ScreenWidth = 2560;
          ScreenHeight = 1440;
          blur = true;
          recursiveBlurLoops = 4;
          recursiveBlurRadius = 15;
        };
      })
    ];

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "chili";
    };

  };
}
