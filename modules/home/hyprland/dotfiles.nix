{ config, lib, ... }:

{
  options = {
    dotfiles.enable = lib.mkEnableOption "Enables dotfiles";
  };

  config = lib.mkIf config.dotfiles.enable {

    home.file = {
      ".config/btop/" = {
        source = ./dotfiles/.config/btop;
        recursive = true;
      };
      ".config/color-scheme/" = {
        source = ./dotfiles/.config/color-scheme;
        recursive = true;
      };
      ".config/homepage/" = {
        source = ./dotfiles/.config/homepage;
        recursive = true;
      };
      ".config/htop/" = {
        source = ./dotfiles/.config/htop;
        recursive = true;
      };
      ".config/hypr/scripts" = {
        source = ./dotfiles/.config/hypr/scripts;
        recursive = true;
      };
      ".config/hypr/wallpapers" = {
        source = ./dotfiles/.config/hypr/wallpapers;
        recursive = true;
      };
      ".config/hypr/hyprlock.conf".source = ./dotfiles/.config/hypr/hyprlock.conf;
      ".config/hypr/hyprpaper.conf".source = ./dotfiles/.config/hypr/hyprpaper.conf;

      ".config/starship/" = {
        source = ./dotfiles/.config/starship;
        recursive = true;
      };
      ".config/Thunar/" = {
        source = ./dotfiles/.config/Thunar;
        recursive = true;
      };
      ".config/tofi/" = {
        source = ./dotfiles/.config/tofi;
        recursive = true;
      };
      ".config/waybar/mediaplayer.py".source = ./dotfiles/.config/waybar/mediaplayer.py;
      ".config/waybar/scripts/" = {
        source = ./dotfiles/.config/waybar/scripts;
        recursive = true;
      };

      ".local/bin/" = {
        source = ./dotfiles/.local/bin;
        recursive = true;
      };
    };

  };
}
