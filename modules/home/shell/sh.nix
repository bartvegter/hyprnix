{ config, lib, pkgs, systemSettings, ... }:

let
  myAliases = {
    ls = "ls --color=auto";
    ll = "ls -al --color=auto";
    grep = "grep --color=auto";
    v = "nvim";
    sv = "sudo nvim";
    code = "codium";
    iv = "xrdb -load $HOME/.Xresources && nsxiv -tars f";
    rp = "$HOME/Documents/Pokemon/ROMHacks/.ROMPatcher";
    h = "cd " + "${systemSettings.hyprnixPath}";
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

    home.packages = with pkgs; [
      cargo
      cmake
      gnumake
      unzip
      zip
    ];

  };
}
