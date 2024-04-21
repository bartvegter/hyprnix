{ config, pkgs, ... }:

{
  services.syncthing = {
    package = pkgs.syncthing;
    enable = true;
    tray.enable = true;
  };
}
