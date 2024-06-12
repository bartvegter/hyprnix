{ config, lib, ... }:

{
  options = {
    hyprpaper.enable = lib.mkEnableOption "Enables hyprpaper";
  };

  config = lib.mkIf config.hyprpaper.enable {

    services.hyprpaper = {
      enable = true;
      settings = {

        preload = "${config.stylix.image}";
        wallpaper = "DP-3, ${config.stylix.image}";

        splash = false;
        ipc = true;
      };
    };

  };
}
