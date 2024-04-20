{ config, pkgs, ... }:
let
  myAliases = {
    ls = "ls --color=auto";
    ll = "ls -al --color=auto";
    grep = "grep --color=auto";
    v = "nvim";
    sv = "sudo nvim";
    code = "codium";
    iv = "xrdb -load $HOME/.Xresources && nsxiv -tars f";
    rp = "/home/bart/Documents/Pokemon/ROMHacks/.ROMPatcher";
    hconf = "cd ~/.config && nvim hypr/hyprland.conf";
    wconf = "cd ~/.config && nvim waybar/config.jsonc";
    dotfiles = "git --git-dir=$HOME/.dotfiles --work-tree=$HOME";
  };
in
{
  # Needed by home manager
  home.username = "bart";
  home.homeDirectory = "/home/bart";

  # Enables ssh-agent for user.
  services.ssh-agent.enable = true;
  programs.ssh.addKeysToAgent = "confirm";

  # Shell setup
  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    # autocd = true;
    history = {
      size = 1000;
      save = 5000;
    };
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # Git
  programs.git = {
    enable = true;
    userName = "Bart Vegter";
    userEmail = "mail@bartvegter.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Hyprland
  # wayland.windowManager.hyprland.enable = true;
  programs.waybar.enable = true;

  # GTK
  # home.pointerCursor = {
  #   gtk.enable = true;
  #   package = pkgs.whitesur-cursors;
  # };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox-Dark-BL";
    };

    # iconTheme = {
    #   package = pkgs.gruvbox-plus-icons;
    #   name = "Gruvbox-Plus-Dark";
    # };
    #
    # cursorTheme = {
    #   package = pkgs.whitesur-cursors;
    #   name = "WhiteSur Cursors";
    # };

    font = {
      name = "Noto Sans SemiCondensed";
      size = 11;
    };
  };

  # Makes QT follow GTK theme
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "gtk2";
  };

  # Makes fonts installed in home.nix discoverable
  fonts.fontconfig.enable = true;

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
    pkgs.gruvbox-plus-icons
    pkgs.whitesur-cursors
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
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
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
    # gtk-2,3,4
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
    # ".config/nvim/".recursive = ./dotfiles/.config/nvim;
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
    # xsettingsd

    ".local/bin/nsxiv-themed.sh".source = ./dotfiles/.local/bin/nsxiv-themed.sh;
    # .icons
    # .themes

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
