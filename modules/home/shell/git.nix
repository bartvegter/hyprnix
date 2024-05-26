{ config, lib, pkgs, userSettings, ... }:

{
  options = {
    git.enable = lib.mkEnableOption "Enables git";
  };

  config = lib.mkIf config.git.enable {

    programs.git = {
      enable = true;
      userName = userSettings.name;
      userEmail = userSettings.email;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    home.packages = with pkgs; [
      lazygit
    ];

  };
}
