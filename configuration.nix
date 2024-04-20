{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

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
  users.users.bart = {
    isNormalUser = true;
    description = "Bart";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  # Time & locale
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  # Networking
  networking.hostName = "hyprnix"; # Define your hostname.
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

  # SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "chili";
    # settings = {
    #   Autologin = {
    #     Session = "hyprland.desktop";
    #     User = "bart";
    #   };
    # };
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
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    cliphist
    kitty
    mako
    sddm-chili-theme
    vim
    wget
    wl-clip-persist
    wl-clipboard
    xdg-desktop-portal-gtk
  ];

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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
