{ config, pkgs, ... }:

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
    hconf = "cd ~/.config && nvim hypr/hyprland.conf";
    wconf = "cd ~/.config && nvim waybar/config.jsonc";
    dotfiles = "git --git-dir=$HOME/.dotfiles --work-tree=$HOME";
  };
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = myAliases;
    # autocd = true;
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
  };
}
