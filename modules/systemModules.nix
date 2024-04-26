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
  ];

  # System defaults defined here.
  # Set moduleName.enable = true / false; in configuration.nix to override.

  # Core // enabled by default.
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

  # VM defaults
  vmGuest.enable =
    if (systemSettings.systemType == "vm") then 
      lib.mkDefault true
    else false;

  # Hyprland // Will be enabled automatically when using Hyprland module.
  pipewire.enable =
    lib.mkIf config.hyprland.enable true;
  sddm.enable =
    lib.mkIf config.hyprland.enable true;

  # Steam // Will be enabled automatically when using Steam module.
  gamemode.enable =
    lib.mkIf config.steam.enable true;
  opengl.enable =
    lib.mkIf config.steam.enable true;

}
