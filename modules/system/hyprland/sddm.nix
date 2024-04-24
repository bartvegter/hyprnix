{ config, lib, pkgs, ... }:

{
  options = {
    sddm.enable = lib.mkEnableOption "Enables SDDM";
  };

  config = lib.mkIf config.sddm.enable {

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "chili";
      # settings = {
      #   Autologin = {
      #     Session = "sddm.desktop";
      #     User = userSettings.username;
      #   };
      # };
    };

    environment.systemPackages = with pkgs; [
      sddm-chili-theme
    ];

  };
}
