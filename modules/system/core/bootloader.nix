{ config, lib, ... }:

{
  options = {
    bootloader.enable = lib.mkEnableOption "Enables bootloader";
  };

  config = lib.mkIf config.bootloader.enable {

    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

  };
}
