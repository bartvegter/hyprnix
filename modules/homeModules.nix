{ ... }:

{

  imports = [
    ./home/app/git.nix
    ./home/app/nvim.nix
    ./home/app/syncthing.nix

    ./home/hyprland/dotfiles.nix
    ./home/hyprland/hyprland.nix

    ./home/shell/sh.nix
    ./home/shell/sshAgent.nix

    ./home/theme/font.nix
    ./home/theme/gtkTheme.nix
  ];

}
