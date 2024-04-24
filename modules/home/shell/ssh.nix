{ config, lib, pkgs, ... }:

{
  options = {
    ssh.enable = lib.mkEnableOption "Enables ssh";
  };

  config = lib.mkIf config.ssh.enable {

    services.ssh-agent.enable = true;
    programs.ssh.addKeysToAgent = "yes";

  };
}
