{ config, lib, systemSettings, ... }:

{
  imports = [
    ./app/corectrl.nix
    ./app/gaming.nix
    ./app/nautilus.nix
    ./app/vmHost.nix

    ./core/bootloader.nix
    ./core/networkSetup.nix
    ./core/sh.nix
    ./core/timeLocale.nix
    ./core/userSetup.nix

    ./hardware/bluetooth.nix
    ./hardware/zenKernel.nix
    ./hardware/amdGPU.nix
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
  bootloader.enable =
    lib.mkDefault true;
  networkSetup.enable =
    lib.mkDefault true;
  sh.enable =
    lib.mkDefault true;
  timeLocale.enable =
    lib.mkDefault true;
  userSetup.enable =
    lib.mkDefault true;
  vmHost.enable =
    lib.mkDefault true;
  wireguard.enable =
    lib.mkDefault true;


  # --- Hardware --- #
  bluetooth.enable =
    lib.mkDefault true;
  corectrl.enable =
    lib.mkDefault true;
  amdGPU.enable =
    lib.mkDefault true;
  vmGuest.enable =
    lib.mkIf (systemSettings.systemType == "vm") (lib.mkDefault true);
  zenKernel.enable =
    lib.mkDefault true;


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
  stylixConfig.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  nautilus.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);


  # --- Steam --- #
  gaming.enable =
    lib.mkDefault true;
}
