{ config, lib, pkgs, ... }:

{
  options = {
    xdgSetup.enable = lib.mkEnableOption "Enables xdgSetup";
  };

  config = lib.mkIf config.xdgSetup.enable {

    xdg = {
      enable = true;
      portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
        configPackages = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
        xdgOpenUsePortal = true;
      };
    };

  };
}
