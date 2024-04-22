{ config, pkgs, ... }:

{
  home.file = {
    ".config/alacritty/" = {
      source = ./dotfiles/.config/alacritty;
      recursive = true;
    };
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
    ".config/hypr/" = {
      source = ./dotfiles/.config/hypr;
      recursive = true;
    };
    ".config/mako/" = {
      source = ./dotfiles/.config/mako;
      recursive = true;
    };
    # ".config/nvim/" = {
    #   source = ./dotfiles/.config/nvim;
    #   recursive = true;
    # };
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
    ".config/waybar/" = {
      source = ./dotfiles/.config/waybar;
      recursive = true;
    };
    ".config/wlogout/" = {
      source = ./dotfiles/.config/wlogout;
      recursive = true;
    };
    # gtk-2,3,4
    # xsettingsd

    ".local/bin/" = {
      source = ./dotfiles/.local/bin;
      recursive = true;
    };
    # .icons
    # .themes
  };
}
