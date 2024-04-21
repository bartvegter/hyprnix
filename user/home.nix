{ config, lib, pkgs, pkgs-stable, systemSettings, userSettings, ... }:

{
  imports = [
    # ./hyprland.nix
    ./sh.nix
    ./theme.nix
  ];

  # Needed by home manager
  home = {
    username = userSettings.username;
    homeDirectory = "/home/" + userSettings.username;
    stateVersion = "23.11"; # Only edit this if you know what you're doing
  };
  programs.home-manager.enable = true;

  # Git
  programs.git = {
    enable = true;
    userName = userSettings.name;
    userEmail = userSettings.email;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Enables ssh-agent for user.
  services.ssh-agent.enable = true;
  programs.ssh.addKeysToAgent = "ask";

  # Syncthing
  services.syncthing = {
    package = pkgs.syncthing;
    enable = true;
    tray.enable = true;
  };

  # Makes fonts installed in home.nix discoverable
  fonts.fontconfig.enable = true;

  # User defined packages
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

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ])

    ++

    (with pkgs-stable; [
      # If any package breaks, try installing the stable version here.
    ]);

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

  home.sessionVariables = {
    EDITOR = userSettings.editor;
    TERM = userSettings.term;
  };
}
