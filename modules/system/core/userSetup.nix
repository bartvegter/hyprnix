{ config, lib, pkgs, userSettings, ... }:

{
  options = {
    userSetup.enable = lib.mkEnableOption "Enables userSetup";
  };

  config = lib.mkIf config.userSetup.enable {

    users.users.${userSettings.username} = {
      isNormalUser = true;
      description = userSettings.name;
      extraGroups = [ "networkmanager" "wheel" ];
      shell = if (userSettings.shell == "zsh") then pkgs.zsh else pkgs.bashInteractive;
      # packages = with pkgs; [];
    };

  };
}
