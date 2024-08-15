{ config, lib, ... }:

{
  options = {
    filesystemSetup.enable = lib.mkEnableOption "Enables filesystemSetup";
  };

  config = lib.mkIf config.filesystemSetup.enable {

    fileSystems."/mnt/HDD" =
      { device = "/dev/disk/by-label/HDD";
        fsType = "ext4";
      };


  };
}
