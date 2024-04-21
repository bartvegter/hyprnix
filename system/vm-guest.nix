{ config, pkgs, ... }:

{
  services.spice-vdagentd.enable = true;
  services.spice-autorandr.enable = true;
}
