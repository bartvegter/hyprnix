{ config, pkgs, userSettings, ... }:

{
  imports = [
    ./fonts.nix
    ./theme.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
  };

  programs.waybar.enable = true;
}
