{ config, lib, pkgs, ... }:

{
  options = {
    kernelSetup.enable = lib.mkEnableOption "Enables zen kernel and applies options";
  };

  config = lib.mkIf config.kernelSetup.enable {

    boot.kernelPackages = pkgs.linuxPackages_zen;

    boot.kernelParams = [ "video=DP-3:2560x1440@165" ];

    boot.extraModprobeConfig = ''
      options hid_apple fnmode=2 iso_layout=0 swap_opt_cmd=1
    '';

  };
}
