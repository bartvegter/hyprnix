{ config, lib, pkgs, ... }:

{
  options = {
    kernel.enable = lib.mkEnableOption "Enables kernel";
  };

  config = lib.mkIf config.kernel.enable {

    boot.kernelPackages = pkgs.linuxPackages_zen;

  };
}
