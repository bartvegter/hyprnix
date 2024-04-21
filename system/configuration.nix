{ config, lib, pkgs, pkgs-stable, systemSettings, userSettings, ... }:

{
  imports = [
    ./hardware-configuration.nix
    #./bluetooth.nix
    ./hyprland.nix
    ./gaming.nix
    ./vm-guest.nix
  ];

  # Important nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Shell setup
  environment = {
    shells = with pkgs; [ bashInteractive zsh ];
    pathsToLink = [ "/share/zsh" ]; # Needed for completion on system packages - see zsh.enableCompletion
  };
  programs.zsh.enable = if (userSettings.shell == "zsh") then true else false;

  # User setup
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.${userSettings.shell};
    # packages = with pkgs; [];
  };

  # Networking
  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true;

  # Time & locale
  time.timeZone = systemSettings.timezone;
  i18n.defaultLocale = systemSettings.language;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };
  services.xserver.xkb = {
    layout = systemSettings.keyboardLayout;
    variant = systemSettings.keyboardVariant;
  };

  # SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "chili";
    # settings = {
    #   Autologin = {
    #     Session = "hyprland.desktop";
    #     User = userSettings.username;
    #   };
    # };
  };

  # System packages
  environment.systemPackages =
    (with pkgs; [
      cliphist
      kitty
      mako
      sddm-chili-theme
      vim
      wget
      wl-clip-persist
      wl-clipboard
      xdg-desktop-portal-gtk
    ])

    ++

    (with pkgs-stable; [
      # If any package breaks, try installing the stable version here.
    ]);

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "23.11"; # Did you read the comment?
}
