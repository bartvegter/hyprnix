{ config, lib, pkgs, ... }:

{
  options = {
    opengl.enable = lib.mkEnableOption "Enables opengl";
  };

  config = lib.mkIf config.opengl.enable {

    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
    };

    services.xserver.videoDrivers = [ "amdgpu" ];

    environment.sessionVariables = {
      RADV_PERFTEST = "aco";
      mesa_glthread = "true";
    };

    environment.systemPackages = with pkgs; [
      clinfo
      vulkan-tools
    ];

  };
}
