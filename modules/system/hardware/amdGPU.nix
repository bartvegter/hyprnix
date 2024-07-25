{ config, lib, pkgs, ... }:

{
  options = {
    amdGPU.enable = lib.mkEnableOption "Enables amdGPU";
  };

  config = lib.mkIf config.amdGPU.enable {

    services.xserver.videoDrivers = [ "amdgpu" ];

    environment.sessionVariables = {
      RADV_PERFTEST = "aco";
      mesa_glthread = "true";
    };

  };
}
