{ config, lib, ... }:

{
  options = {
    vmGuest.enable = lib.mkEnableOption "Enables vmGuest";
  };

  config = lib.mkIf config.vmGuest.enable {

    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;
    services.spice-autorandr.enable = true;

  };
}
