{ config, lib, pkgs, pkgs-stable, systemSettings, userSettings, ... }:

{
  imports = [
    ./file-links.nix
    ./fonts.nix
    ./git.nix
    # ./hyprland.nix
    ./nvim.nix
    ./sh.nix
    # ./syncthing.nix
    ./theme.nix
  ];

  # Needed by home manager
  programs.home-manager.enable = true;

  home = {
    username = userSettings.username;
    homeDirectory = "/home" + "/${userSettings.username}";
    stateVersion = "23.11"; # Only edit this if you know what you're doing
  };

  home.sessionVariables = {
    EDITOR = userSettings.editor;
    TERM = userSettings.term;
    # NIX_CONF_DIR = systemSettings.dotfilesPath;
    # VIMINIT = "$NIX_CONF_DIR/user/dotfiles/.config/nvim/init.lua";
  };

  programs.waybar.enable = true;

  # Enables ssh-agent for user.
  services.ssh-agent.enable = true;
  programs.ssh.addKeysToAgent = "ask";

  # User-specific packages
  nixpkgs.config.allowUnfree = true;
  home.packages =
    (with pkgs; [
      alacritty
      audacity
      baobab
      bat
      blueberry
      brave
      btop
      clinfo
      dosfstools
      exfatprogs
      easyeffects
      firefox
      gnome.gnome-disk-utility
      gnome.file-roller
      gnome.seahorse
      gtk-engine-murrine
      gvfs
      helvum
      hyprlock
      hyprpaper
      hyprpicker
      killall
      libgnome-keyring
      libreoffice-fresh
      neovim
      nsxiv
      nwg-look
      obs-studio
      obsidian
      pavucontrol
      playerctl
      spotify
      tofi
      trash-cli
      udiskie
      viewnior
      vlc
      vulkan-tools
      webcord
      wlogout
      wlsunset
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.thunar-media-tags-plugin
      xfce.thunar-volman
      xfce.tumbler
      xwaylandvideobridge
    ])

    ++

    (with pkgs-stable; [
      # If any package breaks, try installing the stable version here.
    ]);
}
