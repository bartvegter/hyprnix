{ config, lib, userSettings, ... }:

{
  imports = [
    ./home/app/alacritty.nix
    ./home/app/btop.nix
    ./home/app/git.nix
    ./home/app/mako.nix
    ./home/app/nvim.nix
    ./home/app/syncthing.nix
    ./home/app/tofi.nix
    ./home/app/udiskie.nix

    ./home/hyprland/dotfiles.nix
    ./home/hyprland/hyprland.nix
    ./home/hyprland/waybar.nix
    ./home/hyprland/wlogout.nix
    ./home/hyprland/wlsunset.nix
    ./home/hyprland/xdgSetup.nix

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


  # --- Shell --- #
  sh.enable =
    lib.mkDefault true;
  sshAgent.enable =
    lib.mkDefault true;


  # --- Hyprland --- #
  hyprland.enable =
    lib.mkDefault true;
  dotfiles.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  font.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  gtkTheme.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  mako.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  tofi.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  waybar.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  wlogout.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  wlsunset.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  xdgSetup.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);


  # --- Apps --- #
  alacritty.enable =
    lib.mkIf (userSettings.term == "alacritty") (lib.mkDefault true);
  btop.enable =
    lib.mkDefault true;
  git.enable =
    lib.mkDefault true;
  syncthing.enable =
    lib.mkDefault true;
  udiskie.enable =
    lib.mkDefault true;


  # --- Neovim --- #
  nvim.enable =
    lib.mkDefault true;
  go.enable =
    lib.mkIf (config.nvim.enable) (lib.mkDefault true);
  java.enable =
    lib.mkIf (config.nvim.enable) (lib.mkDefault true);
  # nodejs.enable =
  #   lib.mkIf (config.nvim.enable) (lib.mkDefault true);
  php.enable =
    lib.mkIf (config.nvim.enable) (lib.mkDefault true);
  python.enable =
    lib.mkIf (config.nvim.enable) (lib.mkDefault true);
}
