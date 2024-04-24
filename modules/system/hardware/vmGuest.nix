{ config, lib, pkgs, ... }:

{
  options = {
    vmGuest.enable = lib.mkEnableOption "Enables vmGuest";
  };

  config = lib.mkIf config.vmGuest.enable {

    services.spice-vdagentd.enable = true;
    services.spice-autorandr.enable = true;

  };
}
