{ config, lib, ... }:

{
  options = {
    wlsunset.enable = lib.mkEnableOption "Enables wlsunset";
  };

  config = lib.mkIf config.wlsunset.enable {

    # Custom times are not supported by this option as of writing this module.
    # Add the following example to your hyprland startup commands if you want to use these (see wlsunset(1) for options):
    # exec-once = wlsunset -t 3000 -S 8:00 -s 21:00

    services.wlsunset = {
      enable = true;
      systemdTarget = "hyprland-session.target";
      temperature = {
        day = 6500;
        night = 3000;
      };
      latitude = "52.2";
      longitude = "6.2";
    };

  };
}
