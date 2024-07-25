{ config, lib, pkgs, ... }:

{
  options = {
    thunar.enable = lib.mkEnableOption "Enables thunar";
  };

  config = lib.mkIf config.thunar.enable {

    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };

    services.tumbler.enable = true;
    services.gvfs.enable = true;

    environment.systemPackages = with pkgs; [
      file-roller
    ];

  };
}
