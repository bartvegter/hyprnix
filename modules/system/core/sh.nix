{ config, lib, pkgs, userSettings, ... }:

{
  options = {
    sh.enable = lib.mkEnableOption "Enables shell";
  };

  config = lib.mkIf config.sh.enable {

    environment.shells = with pkgs; [ bashInteractive zsh ];
    environment.pathsToLink = [ "/share/bash-completion" "/share/zsh" ]; # Enables completion for system packages

    programs.zsh.enable = if (userSettings.shell == "zsh") then true else false;

  };
}
