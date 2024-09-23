{ config, lib, pkgs, ... }:

{
  options = {
    vmHost.enable = lib.mkEnableOption "Enables vmHost";
  };

  config = lib.mkIf config.vmHost.enable {

    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    # users.users.${userSettings.username}.extraGroups = [ "libvirtd" ];

  };
}
