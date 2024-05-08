{ config, lib, ... }:

{
  options = {
    amdCPU.enable = lib.mkEnableOption "Enables amdCPU";
  };

  config = lib.mkIf config.amdCPU.enable {

    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  };
}
