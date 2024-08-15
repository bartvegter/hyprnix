{ config, lib, systemSettings, ... }:

{
  options = {
    networkSetup.enable = lib.mkEnableOption "Enables networkSetup";
  };

  config = lib.mkIf config.networkSetup.enable {

    networking.hostName = systemSettings.hostname;
    networking.networkmanager.enable = true;
    networking.firewall = {
      enable = true;
      allowPing = true;
    };

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;
    # networking.interfaces.proton.useDHCP = lib.mkDefault true;

  };
}
