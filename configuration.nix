{ config, lib, pkgs, pkgs-stable, systemSettings, userSettings, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Important nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Use when running nixos in a VM
  services.spice-vdagentd.enable = true;
  services.spice-autorandr.enable = true;

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
  programs.zsh.enable = true;

  # User setup
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    # packages = with pkgs; [];
  };

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

  # Networking
  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Bluetooth
  hardware.bluetooth = {
    enable = false;
    powerOnBoot = true;
  };

  # Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
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

  # Hyprland
  programs.hyprland = {
    enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  # Syncthing
  # services.syncthing = {
  #   enable = true;
  #   openDefaultPorts = true;
  # };

  # Graphics
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
    #extraPackages = [
    #rocmPackages.clr
    #];
  };

  # Gaming
  programs.steam = {
    enable = true;
    extest.enable = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
    gamescopeSession = {
      enable = false;
      #env = {};
      #args = [];
    };
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
