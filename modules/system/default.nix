{ config, lib, systemSettings, ... }:

{
  imports = [
    ./app/gaming.nix
    ./app/thunar.nix

    ./core/amdCPU.nix
    ./core/bootloader.nix
    ./core/filesystemSetup.nix
    ./core/kernel.nix
    ./core/networkSetup.nix
    ./core/sh.nix
    ./core/timeLocale.nix
    ./core/userSetup.nix

    ./hardware/bluetooth.nix
    ./hardware/zenKernel.nix
    ./hardware/opengl.nix
    ./hardware/vmGuest.nix

    ./hyprland/gnome-keyring.nix
    ./hyprland/hyprland.nix
    ./hyprland/pipewire.nix
    ./hyprland/polkitGnome.nix
    ./hyprland/sddm.nix

    ./service/samba.nix
    ./service/wireguard.nix

    ./theme/stylix.nix
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
  stylix.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  thunar.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);


  # --- Steam --- #
  gaming.enable =
    lib.mkDefault true;
}
