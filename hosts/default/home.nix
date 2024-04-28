{ config, lib, pkgs, pkgs-stable, systemSettings, userSettings, ... }:

{
  imports = [
    ../../modules/homeModules.nix
  ];

  git.enable = true;
  nvim.enable = true;
  syncthing.enable = true;

  dotfiles.enable = true;
  hyprland.enable = false;
  waybar.enable = true;
  wlogout.enable = true;

  sh.enable = true;
  sshAgent.enable = true;

  font.enable = true;
  gtkTheme.enable = true;

  home.sessionVariables = {
    EDITOR = userSettings.editor;
    TERM = userSettings.term;
    # NIX_CONF_DIR = systemSettings.dotfilesPath;
    # VIMINIT = "$NIX_CONF_DIR/user/dotfiles/.config/nvim/init.lua";
  };

  # User-specific packages
  home.packages =
    (with pkgs; [
      neovim
      alacritty
      audacity
      baobab
      bat
      blueberry
      brave
      btop
      clinfo
      easyeffects
      firefox
      gnome.gnome-disk-utility
      gnome.file-roller
      gnome.seahorse
      gtk-engine-murrine
      helvum
      hyprlock
      hyprpaper
      hyprpicker
      killall
      libreoffice-fresh
      nsxiv
      nwg-look
      obs-studio
      obsidian
      pavucontrol
      playerctl
      spotify
      tofi
      tree
      trash-cli
      udiskie
      viewnior
      vlc
      vulkan-tools
      webcord
      wlsunset
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.thunar-media-tags-plugin
      xfce.thunar-volman
      xfce.tumbler
      xorg.xrdb
      xwaylandvideobridge
    ])

    ++

    (with pkgs-stable; [
      #
    ]);

  # Home manager settings
  programs.home-manager.enable = true;
  home = {
    username = userSettings.username;
    homeDirectory = "/home" + "/${userSettings.username}";
  };

  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "23.11"; # Only edit this if you know what you're doing

}
