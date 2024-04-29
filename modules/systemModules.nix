{ config, lib, systemSettings, ... }:

{
  imports = [
    ./system/app/gamemode.nix
    ./system/app/steam.nix

    ./system/core/bootloader.nix
    ./system/core/networkSetup.nix
    ./system/core/sh.nix
    ./system/core/timeLocale.nix
    ./system/core/userSetup.nix

    ./system/hardware/bluetooth.nix
    ./system/hardware/zenKernel.nix
    ./system/hardware/opengl.nix
    ./system/hardware/vmGuest.nix

    ./system/hyprland/hyprland.nix
    ./system/hyprland/pipewire.nix
    ./system/hyprland/polkitGnome.nix
    ./system/hyprland/sddm.nix
    ./system/hyprland/xdgPortal.nix
  ];


  # --- Core --- #
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
  pipewire.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  polkitGnome.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  sddm.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);
  xdgPortal.enable =
    lib.mkIf (config.hyprland.enable) (lib.mkDefault true);


  # --- Steam --- #
  steam.enable =
    lib.mkDefault true;
  gamemode.enable =
    lib.mkIf (config.steam.enable) (lib.mkDefault true);
}
