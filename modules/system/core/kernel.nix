{ config, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  options = {
    kernel.enable = lib.mkEnableOption "Enables kernel";
  };

  config = lib.mkIf config.kernel.enable {

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];

    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    boot.kernelParams = [ "video=DP-3:2560x1440@165" ];

    boot.extraModprobeConfig = ''
      options hid_apple fnmode=2 iso_layout=0 swap_opt_cmd=1
    '';

  };
}
