{ config, lib, pkgs, ... }:

{
  options = {
    zenKernel.enable = lib.mkEnableOption "Enables zenKernel";
  };

  config = lib.mkIf config.zenKernel.enable {

    boot.kernelPackages = pkgs.linuxPackages_zen;

  };
}
