{ ... }:

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
    ./system/hardware/kernel.nix
    ./system/hardware/opengl.nix
    ./system/hardware/vmGuest.nix

    ./system/hyprland/hyprland.nix
    ./system/hyprland/pipewire.nix
    ./system/hyprland/sddm.nix
  ];

}
