{ config, lib, ... }:

{

  imports = [
    ./home/app/git.nix
    ./home/app/nvim.nix
    ./home/app/syncthing.nix

    ./home/hyprland/dotfiles.nix
    ./home/hyprland/hyprland.nix
    ./home/hyprland/wlogout.nix

    ./home/shell/sh.nix
    ./home/shell/sshAgent.nix

    ./home/theme/font.nix
    ./home/theme/gtkTheme.nix
  ];

  # Hyprland // Will be enabled automatically when using Hyprland module.
  dotfiles.enable =
    lib.mkIf config.hyprland.enable true;
  font.enable =
    lib.mkIf config.hyprland.enable true;
  gtkTheme.enable =
    lib.mkIf config.hyprland.enable true;
  wlogout.enable =
    lib.mkIf config.hyprland.enable true;

}
