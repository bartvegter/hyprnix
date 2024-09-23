{ config, lib, pkgs, systemSettings, ... }:

let
  systemRebuild = pkgs.writeShellScriptBin "systemRebuild" ''
    if [[ $# -eq 0 ]]; then
      cd ${systemSettings.hyprnixPath} && sudo nixos-rebuild switch --flake .
    elif [[ $1 == "switch" || $1 == "test" || $1 == "boot" ]]; then
      cd ${systemSettings.hyprnixPath} && sudo nixos-rebuild $1 --flake .
    elif [[ $1 == "upgrade" ]]; then
      cd ${systemSettings.hyprnixPath} && nix flake update && git add flake.lock && sudo nixos-rebuild switch --flake .
    else
      echo "Invalid or too many arguments given"
      echo "usage: systemRebuild [switch (default) / test / boot / upgrade (switch + flake update)]"
    fi
  '';

  myAliases = {
    ls = "ls --color=auto";
    ll = "ls -alh --color=auto";
    grep = "grep --color=auto";
    v = "nvim";
    sv = "sudo nvim";
    code = "codium";
    iv = "nsxiv -ftars f";
    iv-random = "find . -type f | shuf | nsxiv -ifars f";
    h = "cd ${systemSettings.hyprnixPath}";
    hl = "lazygit --path=${systemSettings.hyprnixPath}";
    hv = "cd ${systemSettings.hyprnixPath} && $EDITOR";
    sr = "${lib.getExe systemRebuild}";
  };
in
{
  options = {
    sh.enable = lib.mkEnableOption "Enables shell";
  };

  config = lib.mkIf config.sh.enable {

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = myAliases;
      autocd = true;
    };

    programs.bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = myAliases;
    };

    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      settings = {
        "$schema" = "https://starship.rs/config-schema.json";
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
        };
        package = {
          disabled = true;
        };
      };
    };

    programs.autojump.enable = true;

    home.packages = with pkgs; [
      bat
      cargo
      cmake
      gnumake
      systemRebuild
      tldr
      trash-cli
      tree
      unzip
      zip
    ];

  };
}
