#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return


alias ls='ls --color=auto'
alias ll='ls -al --color=auto'
alias grep='grep --color=auto'
alias code='codium'
alias v='nvim'
alias sv='sudo nvim'
alias iv='xrdb -load $HOME/.Xresources && nsxiv -tars f'
alias hconf='cd ~/.config && nvim hypr/hyprland.conf'
alias wconf='cd ~/.config && nvim waybar/config.jsonc'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias rp='/home/bart/Documents/Pokemon/ROMHacks/.ROMPatcher'
alias nr='sudo nixos-rebuild switch -I nixos-config=$HOME/.hyprnix/configuration.nix'
alias nr-test='sudo nixos-rebuild test -I nixos-config=$HOME/.hyprnix/configuration.nix'
alias nr-boot='sudo nixos-rebuild boot -I nixos-config=$HOME/.hyprnix/configuration.nix'

if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"
