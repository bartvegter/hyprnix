{ config, lib, ... }:

{

  imports = [
    ./home/app/git.nix
    ./home/app/nvim.nix
    ./home/app/syncthing.nix

    ./home/hyprland/dotfiles.nix
    ./home/hyprland/hyprland.nix
    ./home/hyprland/waybar.nix
    ./home/hyprland/wlogout.nix

    ./home/lang/go.nix
    ./home/lang/java.nix
    ./home/lang/nodejs.nix
    ./home/lang/php.nix
    ./home/lang/python.nix

    ./home/shell/sh.nix
    ./home/shell/sshAgent.nix

    ./home/theme/font.nix
    ./home/theme/gtkTheme.nix
  ];

  # Hyprland defaults
  dotfiles.enable =
    lib.mkIf config.hyprland.enable true;
  font.enable =
    lib.mkIf config.hyprland.enable true;
  gtkTheme.enable =
    lib.mkIf config.hyprland.enable true;
  waybar.enable =
    lib.mkIf config.hyprland.enable true;
  wlogout.enable =
    lib.mkIf config.hyprland.enable true;

  # Neovim defaults
  go.enable =
    lib.mkIf config.nvim.enable true;
  java.enable =
    lib.mkIf config.nvim.enable true;
  # nodejs.enable =
  #   lib.mkIf config.nvim.enable true;
  php.enable =
    lib.mkIf config.nvim.enable true;
  python.enable =
    lib.mkIf config.nvim.enable true;

}
