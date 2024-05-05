{ config, lib, ... }:

{
  options = {
    gnome-keyring.enable = lib.mkEnableOption "Enables gnome-keyring";
  };

  config = lib.mkIf config.gnome-keyring.enable {

    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;

  };
}
