#!/usr/bin/env sh

# Automated script for installing my dotfiles on NixOS.
# Shout-out to @LibrePhoenix for showing how to set this up using a flake.

if [
  # Set script directory
  if [ $# -gt 0 ]
    then
      SCRIPT_DIR=$1
    else
      SCRIPT_DIR=~/.hyprnix
  fi

  # Function for adding changes made during install to working tree. Changes won't be included in rebuild otherwise
  function gitAdd { git --git-dir=$SCRIPT_DIR/.git --work-tree=$SCRIPT_DIR add $SCRIPT_DIR; }

  # Clone dotfiles
  nix-shell -p git --command "git clone https://github.com/bartvegter/hyprnix $SCRIPT_DIR"

  echo && echo ":: The system will ask for your sudo password, which is required for generating the hardware config and for rebuilding the system configuration."
  echo ":: Feel free to check out the install script at https://github.com/bartvegter/hyprnix/blob/main/install.sh"

  # Generate hardware config for new system
  sudo nixos-generate-config --show-hardware-config > $SCRIPT_DIR/system/hardware-configuration.nix
  gitAdd

  # Set UEFI or BIOS bootMode
  if [ -d /sys/firmware/efi/efivars ]; then
      sed -i "0,/bootMode.*=.*\".*\";/s//bootMode = \"uefi\";/" $SCRIPT_DIR/flake.nix
      echo && echo ":: Detected UEFI compatibility"
      echo ":: Setting bootMode to UEFI..." && echo
  else
      sed -i "0,/bootMode.*=.*\".*\";/s//bootMode = \"bios\";/" $SCRIPT_DIR/flake.nix
      grubDevice=$(findmnt / | awk -F' ' '{ print $2 }' | sed 's/\[.*\]//g' | tail -n 1 | lsblk -no pkname | tail -n 1 )
      sed -i "0,/grubDevice.*=.*\".*\";/s//grubDevice = \"\/dev\/$grubDevice\";/" $SCRIPT_DIR/flake.nix
      echo && echo ":: Could not detect UEFI compatibility"
      echo ":: Setting bootMode to BIOS (legacy)..."
  fi
  gitAdd

  # systemSettings & userSettings setup
  echo
  while true; do
    read -p ":: Would you like to change the default configuration? (recommended) [Y/n]: " ynConf
    case $ynConf in
      "" | "Y" | "y")

        echo
        while true; do
          read -p ":: (1/5) Please enter your username as in /home/{username}/ (ex. 'bart'): " username
          if [ -z $username ]; then
            echo ":: Username cannot be empty, try again..." && echo
          else
            break
          fi
        done

        echo
        while true; do
          read -p ":: (2/5) Please enter your name for user description and git commits (ex. 'Bart'): " name
          if [ -z $name ]; then
            echo ":: Name cannot be empty, try again..." && echo
          else
            break
          fi
        done

        echo && read -p ":: (3/5) Please enter your email address for git commits (optional, ex. 'example@example.com'): " email

        echo
        while true; do
          read -p ":: (4/5) Would you like to use zsh as your default shell, instead of bash? [Y/n]: " ynShell
          case $ynShell in
            "" | "Y" | "y")
              break
              ;;

            "N" | "n")
              sed -i "0,/zsh/s//bashInteractive/" $SCRIPT_DIR/flake.nix
              break
              ;;

            *)
            echo ":: Invalid input, please try again..." && echo
            echo ":: Valid values are [Y] or [n] (case insensitive), or press [return] for default (Y)"
            ;;
          esac
        done

        echo
        while true; do
          read -p ":: (5/5) Please choose a default editor [neovim|vim|nano|vscode/vscodium(will use nano in terminal)]: " editor
          case $editor in
            "neovim" | "nvim")
              break
              ;;

            "vim" | "nano")
              sed -i "0,/neovim/s//$editor/" $SCRIPT_DIR/flake.nix
              break
              ;;

            "vscode" | "vscodium")
              sed -i "0,/neovim/s//$editor/" $SCRIPT_DIR/flake.nix
              $editor = nano
              break
              ;;

            *)
              echo ":: Invalid input, please try again..." && echo
              echo ":: Valid values are listed below in between [], enter value in lower case"
              ;;
          esac
        done

        echo && echo ":: Applying user settings..."
        sed -i "0,/bart/s//$username/" $SCRIPT_DIR/flake.nix
        sed -i "0,/Bart/s//$name/" $SCRIPT_DIR/flake.nix
        sed -i "0,/contact@bartvegter.com/s//$email/" $SCRIPT_DIR/flake.nix
        break
        ;;

      "N" | "n")
        echo && echo ":: Setting system defaults..."
        sed -i "0,/bart/s//$(whoami)/" $SCRIPT_DIR/flake.nix
        sed -i "0,/Bart/s//$(getent passwd $(whoami) | cut -d ':' -f 5 | cut -d ',' -f 1)/" $SCRIPT_DIR/flake.nix
        sed -i "s/contact@bartvegter.com//" $SCRIPT_DIR/flake.nix
        break
        ;;

      *)
        echo ":: Invalid input, please try again..." && echo
        echo ":: Valid values are [Y] or [n] (case insensitive), or press [return] for default (Y)"
        ;;
    esac
  done
  gitAdd

  if [ -z $EDITOR ]; then
    EDITOR = $editor
  fi

  # Open up editor to manually edit flake.nix before install
  echo
  while true; do
    read -p ":: Would you like to manually edit flake.nix for further configuration? [y/N]: " ynManual
    case $ynManual in
      "Y" | "y")
        $EDITOR $SCRIPT_DIR/flake.nix;
        gitAdd
        break
        ;;

      "" | "N" | "n")
        break
        ;;

      *)
        echo ":: Invalid input, please try again..." && echo
        echo ":: Valid values are [y] or [N] (case insensitive), or press [return] for default (N)"
        ;;
    esac
  done

  # Permissions for files that should be owned by root
  # sudo $SCRIPT_DIR/harden.sh $SCRIPT_DIR;

  echo && echo ":: Starting system rebuild..."

  # Rebuild system
  sudo nixos-rebuild --no-write-lock-file switch --flake $SCRIPT_DIR#system;
  gitAdd

  # Install and build home-manager configuration
  nix run home-manager/master --extra-experimental-features nix-command --extra-experimental-features flakes --no-write-lock-file -- switch --flake $SCRIPT_DIR#user;
  gitAdd
  ]; then
  # Prompt for rebooting
  echo && echo ":: Hyprnix installed successfully" && echo

  while true; do
    read -p ":: Would you like to reboot into Hyprland? [Y/n]: " ynReboot
    case $ynReboot in
      "" | "Y" | "y")
        echo && echo ":: Rebooting system..."
        systemctl reboot
        exit
        ;;

      "N" | "n")
        echo && break
        ;;

      *)
        echo && echo ":: Invalid input, exiting..."
        ;;
    esac
  done

  echo ":: When ready, run 'systemctl reboot' to reboot into Hyprland"
  exit
else
  echo && echo ":: Hyprnix failed to install. See error log above"
  exit 1
fi
