{ inputs, config, lib, pkgs, pkgs-stable, systemSettings, userSettings, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/systemModules.nix
  ];

  bluetooth.enable = true;
  zenKernel.enable = true;
  hyprland.enable = true;
  steam.enable = true;

  environment.systemPackages =
    (with pkgs; [
      dosfstools
      exfatprogs
      gvfs
      vim
      wget
    ])

    ++

    (with pkgs-stable; [
      #
    ]);

  # Editing the following may cause severe headaches
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11"; # Never edit unless absolutely necessary
}
