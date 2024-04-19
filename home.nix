{ config, pkgs, ... }:

{
  # Home manager defaults
  home.username = "bart";
  home.homeDirectory = "/home/bart";

  # Makes fonts installed in home.nix discoverable
  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    userName = "Bart Vegter";
    userEmail = "mail@bartvegter.com";
  };

  # User defined packages
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
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
    gruvbox-dark-gtk
    gruvbox-dark-icons-gtk
    gruvbox-gtk-theme
    gtk-engine-murrine
    gnome.gnome-disk-utility
    gnome.file-roller
    gnome.seahorse
    gvfs
    helvum
    hyprlock
    hyprpaper
    hyprpicker
    killall
    libgnome-keyring
    libreoffice-fresh
    neovim
    noto-fonts
    noto-fonts-lgc-plus
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    nsxiv
    nwg-look
    obs-studio
    obsidian
    pavucontrol
    playerctl
    sddm-chili-theme
    spotify
    starship
    tofi
    trash-cli
    udiskie
    viewnior
    vlc
    vulkan-tools
    webcord
    whitesur-cursors
    wlogout
    wlsunset
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    xfce.thunar-volman
    xfce.tumbler
    xwaylandvideobridge

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/bart/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
