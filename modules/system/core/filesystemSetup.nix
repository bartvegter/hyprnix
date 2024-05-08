{ config, lib, ... }:

{
  options = {
    filesystemSetup.enable = lib.mkEnableOption "Enables filesystemSetup";
  };

  config = lib.mkIf config.filesystemSetup.enable {

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/f2d32d12-bc6a-4d84-b567-3ad45be75f57";
        fsType = "ext4";
      };

    fileSystems."/mnt/HDD" =
      { device = "/dev/disk/by-label/HDD";
        fsType = "ext4";
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/00B3-7588";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };

    swapDevices = [
      { device = "/dev/disk/by-uuid/1f7eb381-737a-40ff-83be-57f7483a5e92"; }
    ];

  };
}
