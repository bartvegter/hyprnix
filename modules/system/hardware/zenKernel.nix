{ config, lib, pkgs, ... }:

{
  options = {
    zenKernel.enable = lib.mkEnableOption "Enables zen kernel";
  };

  config = lib.mkIf config.zenKernel.enable {

    boot.kernelPackages = pkgs.linuxPackages_zen;

  };
}
