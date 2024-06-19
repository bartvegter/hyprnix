{ config, lib, ... }:

{
  options = {
    hyprpaper.enable = lib.mkEnableOption "Enables hyprpaper";
  };

  config = lib.mkIf config.hyprpaper.enable {

    services.hyprpaper = {
      enable = true;
      settings = {

        preload = lib.mkDefault "${config.stylix.image}";
        wallpaper = lib.mkDefault "DP-3, ${config.stylix.image}";

        splash = false;
        ipc = true;
      };
    };

  };
}
