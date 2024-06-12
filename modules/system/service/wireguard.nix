{ config, lib, pkgs, ... }:

{
  options = {
    wireguard.enable = lib.mkEnableOption "Enables wireguard";
  };

  config = lib.mkIf config.wireguard.enable {

    networking.wg-quick.interfaces.proton = {
      autostart = true;
      configFile = "/etc/wireguard/nix-NL-247.conf";
    };

    environment.systemPackages = with pkgs; [
      wireguard-tools
    ];

  };
}
