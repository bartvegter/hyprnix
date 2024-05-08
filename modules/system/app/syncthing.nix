{ config, lib, userSettings, ... }:

{
  options = {
    syncthing.enable = lib.mkEnableOption "Enables syncthing";
  };

  config = lib.mkIf config.syncthing.enable {

    services.syncthing = {
      enable = true;
      # user = userSettings.username;
      openDefaultPorts = true;
    };

  };
}
