{ config, lib, ... }:

{
  options = {
    udiskie.enable = lib.mkEnableOption "Enables udiskie";
  };

  config = lib.mkIf config.udiskie.enable {

    services.udiskie = {
      enable = true;
      notify = true;
      tray = "auto";
      automount = true;
      # settings = { };
    };

  };
}
