{ config, lib, systemSettings, ... }:

{
  imports = [
    ./system/app/gaming.nix
    ./system/app/samba.nix
    ./system/app/syncthing.nix
    ./system/app/thunar.nix
    ./system/app/wireguard.nix

    ./system/core/amdCPU.nix
    ./system/core/bootloader.nix
    ./system/core/filesystemSetup.nix
    ./system/core/kernel.nix
    ./system/core/networkSetup.nix
    ./system/core/sh.nix
    ./system/core/timeLocale.nix
    ./system/core/userSetup.nix

    ./system/hardware/bluetooth.nix
    ./system/hardware/zenKernel.nix
    ./system/hardware/opengl.nix
    ./system/hardware/vmGuest.nix

    ./system/hyprland/gnome-keyring.nix
    ./system/hyprland/hyprland.nix
    ./system/hyprland/pipewire.nix
    ./system/hyprland/polkitGnome.nix
    ./system/hyprland/sddm.nix
  ];


  # --- Core --- #
  # Need to add if statements which check for the existence of hardware-configuration.nix.
  amdCPU.enable =
    lib.mkDefault true;
  bootloader.enable =
    lib.mkDefault true;
  filesystemSetup.enable =
    lib.mkDefault true;
  kernel.enable =
    lib.mkDefault true; 
  networkSetup.enable =
    lib.mkDefault true;
  sh.enable =
    lib.mkDefault true;
  timeLocale.enable =
    lib.mkDefault true;
  userSetup.enable =
    lib.mkDefault true;

  syncthing.enable =
    lib.mkDefault true;
  wireguard.enable =
    lib.mkDefault true;

  # --- Hardware --- #
  bluetooth.enable =
    lib.mkDefault true;
  zenKernel.enable =
    lib.mkDefault true;
  opengl.enable =
    lib.mkDefault true;
  vmGuest.enable =
    lib.mkIf (systemSettings.systemType == "vm") (lib.mkDefault true);


  # --- Hyprland --- #
  hyprland.enable =
    lib.mkDefault true;
  gnome-keyring.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  pipewire.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  polkitGnome.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  sddm.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  thunar.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);


  # --- Steam --- #
  gaming.enable =
    lib.mkDefault true;
}
