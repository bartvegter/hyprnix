{ config, lib, pkgs, ... }:

{
  options = {
    sshAgent.enable = lib.mkEnableOption "Enables ssh agent";
  };

  config = lib.mkIf config.sshAgent.enable {

    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };
    services.ssh-agent.enable = true;

  };
}
