{ inputs, config, lib, pkgs, pkgs-stable, systemSettings, userSettings, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/systemModules.nix
  ];

  bootloader.enable = true;
  networkSetup.enable = true;
  sh.enable = true;
  timeLocale.enable = true;
  userSetup.enable = true;

  bluetooth.enable = true;
  kernel.enable = true;
  opengl.enable = true;
  vmGuest.enable = if (systemSettings.systemType == "vm") then true else false;

  hyprland.enable = true;
  pipewire.enable = true;
  sddm.enable = true;

  gamemode.enable = true;
  steam.enable = true;

  environment.systemPackages =
    (with pkgs; [
      dosfstools
      exfatprogs
      vim
      wget
    ])

    ++

    (with pkgs-stable; [
      #
    ]);

  # Editing the following may cause severe headaches
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11"; # Never edit unless absolutely necessary
}
