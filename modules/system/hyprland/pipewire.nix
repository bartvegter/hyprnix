{ config, lib, pkgs, ... }:

{
  options = {
    pipewire.enable = lib.mkEnableOption "Enables pipewire";
  };

  config = lib.mkIf config.pipewire.enable {

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      wireplumber.enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;
    };

  };
}
