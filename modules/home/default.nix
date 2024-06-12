{ config, lib, userSettings, ... }:

{
  imports = [
    ./app/alacritty.nix
    ./app/btop.nix
    ./app/nvim.nix
    ./app/tofi.nix

    ./hyprland/hyprland.nix
    ./hyprland/waybar.nix
    ./hyprland/wlogout.nix
    ./hyprland/wlsunset.nix
    ./hyprland/xdgPortals.nix

    ./lang/go.nix
    ./lang/java.nix
    ./lang/nodejs.nix
    ./lang/php.nix
    ./lang/python.nix

    ./service/mako.nix
    ./service/syncthing.nix
    ./service/udiskie.nix

    ./shell/git.nix
    ./shell/sh.nix
    ./shell/sshAgent.nix

    ./theme/theming.nix
  ];


  # --- Shell --- #
  sh.enable =
    lib.mkDefault true;
  sshAgent.enable =
    lib.mkDefault true;


  # --- Hyprland --- #
  hyprland.enable =
    lib.mkDefault true;
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  mako.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  theming.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  tofi.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  waybar.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  wlogout.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  wlsunset.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  xdgPortals.enable =
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
