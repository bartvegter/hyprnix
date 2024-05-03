{ pkgs, pkgs-alt, userSettings, ... }:

{
  imports = [
    # The module imported here imports all other modules from [modules/home/] and enables most by default.
    # See the overrides section below if you want to change the default config.
    ../../modules/homeModules.nix
  ];

  # --- Module overrides section --- #
  # If you want to change any module defaults set in [modules/homeModules.nix], it is recommended to change them here.
  # E.g. for syncthing, use:
  # syncthing.enable = false;

  # --- User specific variables --- #
  # System-wide variables can be set in configuration.nix.
  home.sessionVariables = {
    EDITOR = userSettings.editor;
    TERM = userSettings.term;
    XDG_SCREENSHOTS_DIR = "$HOME/Pictures/Screenshots/";
  };

  # --- User specific packages --- #
  home.packages =
    (with pkgs; [
      neovim
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
      gnome.seahorse
      grimblast
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
      viewnior
      vlc
      vulkan-tools
      webcord
      xorg.xrdb
      xwaylandvideobridge
    ])

    ++

    (with pkgs-alt; [
      # If any package breaks: try installing the alternate (stable/unstable) version here, or revert you flake.lock update using git and rebuild.
    ]);

  # --- Home manager settings --- #
  # Recommended to leave these as they are. Changing anything here might brick your system.
  programs.home-manager.enable = true;
  home.username = userSettings.username;
  home.homeDirectory = "/home" + "/${userSettings.username}";
  # Only edit this if you know what you're doing.
  home.stateVersion = "23.11";

  # --- Nix settings --- #
  # Ensures nix command and flakes are enabled && Enables packages with unfree license.
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  nixpkgs.config.allowUnfree = true;
}
