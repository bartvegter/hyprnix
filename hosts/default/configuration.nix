{ lib, pkgs, pkgs-alt, systemSettings, ... }:

{
  imports = [
    # ./hardware-configuration.nix
    # The module imported here imports all other modules from [modules/system/] and enables most by default.
    # See the overrides section below if you want to change the default config.
    ../../modules/system
  ];

  # --- Module overrides section --- #
  # If you want to change any module defaults set in [modules/system/default.nix], it is recommended to override them here.
  # E.g. for bluetooth, use:
  # bluetooth.enable = false;

  # --- System-wide variables --- #
  # User specific variables can be set in home.nix.
  environment.sessionVariables = {
    #
  };

  # --- System-wide packages --- #
  environment.systemPackages =
    (with pkgs; [
      dosfstools
      exfatprogs
      vim
      wget
    ])

    ++

    (with pkgs-alt; [
      # If any package breaks: try installing the alternate (stable/unstable) version here, or revert you flake.lock update using git and rebuild.
    ]);

  # --- NixOS settings --- #
  # Only edit this if you know what you're doing
  system.stateVersion = "23.11";
  nixpkgs.hostPlatform = lib.mkDefault systemSettings.system;

  # --- Nix settings --- #
  # Ensures nix command and flakes are enabled and enables packages with unfree license
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  nixpkgs.config.allowUnfree = true;
}
