{ config, lib, pkgs, ... }:

{
  options = {
    hyprland.enable = lib.mkEnableOption "Enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
    };

    programs.waybar.enable = true;

  };
}
