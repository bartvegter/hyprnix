# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=5000
setopt autocd nomatch
unsetopt beep notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/bart/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

alias ls='ls --color=auto'
alias ll='ls -al --color=auto'
alias grep='grep --color=auto'
alias v='nvim'
alias sv='sudo nvim'
alias code='codium'
alias iv='xrdb -load $HOME/.Xresources && nsxiv -tars f'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias hconf='cd ~/.config/hypr/ && nvim hyprland.conf'
alias wconf='cd ~/.config/waybar/ && nvim config.jsonc'
alias rp='/home/bart/Documents/Pokemon/ROMHacks/.ROMPatcher'
alias nr='sudo nixos-rebuild switch -I nixos-config=$HOME/.hyprnix/configuration.nix'
alias nr-test='sudo nixos-rebuild test -I nixos-config=$HOME/.hyprnix/configuration.nix'
alias nr-boot='sudo nixos-rebuild boot -I nixos-config=$HOME/.hyprnix/configuration.nix'

#PS1='[\u@\h \W]\$ '

eval "$(starship init zsh)"
