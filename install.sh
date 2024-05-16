#!/usr/bin/env sh

# Automated script for installing my dotfiles on NixOS.
# Shout-out to @LibrePhoenix for showing how to set this up using a flake.

# Set script directory
if [ $# -gt 0 ]
  then
    SCRIPT_DIR=$1
  else
    SCRIPT_DIR=~/.hyprnix
fi

# Function for adding changes made during install to working tree. Changes won't be included in rebuild otherwise
gitAdd() { 
  git --git-dir=$SCRIPT_DIR/.git --work-tree=$SCRIPT_DIR add $SCRIPT_DIR;
}

# Makes it easier to set options defined in systemSettings and userSettings in flake.nix
setOption() {
  if [ $# -le 1 ]; then
    echo ":: Error: Invalid usage of setOption. Not enough arguments given."
    echo ":: Valid usage looks like: setOption [option] [setting], e.g. setOption hostname hyprnix"
  elif [ $# -ge 3 ]; then
    echo ":: Error: Invalid usage of setOption. Too many arguments given."
    echo ":: Valid usage looks like: setOption [option] [setting], e.g. setOption hostname hyprnix"
  else
    local option=$1
    local value=$2
    sed -i "0,/$option.*=.*\".*\";/s//$option = \"$value\";/" $SCRIPT_DIR/flake.nix
  fi
}

# Clone dotfiles
nix-shell -p git --command "git clone https://github.com/bartvegter/hyprnix $SCRIPT_DIR"

echo && echo ":: The system will ask for your sudo password, which is required for generating the hardware config and for rebuilding the system configuration"
echo ":: Feel free to check out the install script at https://github.com/bartvegter/hyprnix/blob/main/install.sh"

# Generate hardware config for new system
sudo nixos-generate-config --show-hardware-config > $SCRIPT_DIR/system/hardware-configuration.nix

gitAdd

# Set UEFI or BIOS bootMode
if [ -d /sys/firmware/efi/efivars ]; then
    echo && echo ":: Detected UEFI compatibility"
    echo ":: Setting bootMode to UEFI..." && echo
    setOption bootMode uefi
    # sed -i "0,/bootMode.*=.*\".*\";/s//bootMode = \"uefi\";/" $SCRIPT_DIR/flake.nix
else
    echo && echo ":: Could not detect UEFI compatibility"
    echo ":: Setting bootMode to BIOS (legacy)..."
    setOption bootMode bios
    # sed -i "0,/bootMode.*=.*\".*\";/s//bootMode = \"bios\";/" $SCRIPT_DIR/flake.nix
    grubDevice=$(findmnt / | awk -F' ' '{ print $2 }' | sed 's/\[.*\]//g' | tail -n 1 | lsblk -no pkname | tail -n 1 )
    setOption grubDevice \/dev\/$grubDevice
    # sed -i "0,/grubDevice.*=.*\".*\";/s//grubDevice = \"\/dev\/$grubDevice\";/" $SCRIPT_DIR/flake.nix
fi

gitAdd

echo
while true; do
  read -p ">> Are you running NixOS in a VM? [y/N]: " ynVM
  case $ynVM in
    "Y" | "y")
      setOption systemType vm
      # sed -i "0,/hardware/s//vm/" $SCRIPT_DIR/flake.nix
      break
      ;;

    "" | "N" | "n")
      break
      ;;

    *)
      echo ":: Invalid input, please try again..." && echo
      echo ":: Valid values are [y]es or [N]o (case insensitive), or press [return] for default (No)"
      ;;
  esac
done

# systemSettings & userSettings setup
while true; do
  read -p ">> Would you like to change the default configuration? (recommended) [Y/n]: " ynConf
  case $ynConf in
    "" | "Y" | "y")

      echo
      while true; do
        read -p ">> (1/6) Please enter your preferred system hostname (e.g. 'nixos'): " hostname
        if [ -z $hostname ]; then
          echo ":: Hostname cannot be empty, try again..." && echo
        else
          break
        fi
      done

      echo
      while true; do
        read -p ">> (2/6) Please enter your username as in /home/{username}/ (e.g. 'john'): " username
        if [ -z $username ]; then
          echo ":: Username cannot be empty, try again..." && echo
        else
          break
        fi
      done

      echo
      while true; do
        read -p ">> (3/6) Please enter your name for user description and git commits (e.g. 'John Smith'): " name
        if [ -z $name ]; then
          echo ":: Name cannot be empty, try again..." && echo
        else
          break
        fi
      done

      echo && read -p ">> (4/6) Please enter your email address for git commits (optional, e.g. 'example@example.com'): " email

      echo
      while true; do
        read -p ">> (5/6) Would you like to use zsh as your default shell, instead of bash? [Y/n]: " ynShell
        case $ynShell in
          "" | "Y" | "y")
            break
            ;;

          "N" | "n")
            setOption shell bashInteractive
            # sed -i "0,/zsh/s//bashInteractive/" $SCRIPT_DIR/flake.nix
            break
            ;;

          *)
          echo ":: Invalid input, please try again..." && echo
          echo ":: Valid values are [Y]es or [n]o (case insensitive), or press [return] for default (Yes)"
          ;;
        esac
      done

      echo
      while true; do
        read -p ">> (6/6) Please choose a default editor [ neovim | vim | nano | [vscode / vscodium] (both will use nano during install) ]: " editor
        case $editor in
          "neovim" | "nvim")
            $editor="nvim";
            break
            ;;

          "vim" | "nano")
            setOption editor $editor
            # sed -i "0,/nvim/s//$editor/" $SCRIPT_DIR/flake.nix
            break
            ;;

          "vscode" | "vscodium")
            setOption editor $editor
            # sed -i "0,/nvim/s//$editor/" $SCRIPT_DIR/flake.nix
            $editor="nano";
            break
            ;;

          *)
            echo ":: Invalid input, please try again..." && echo
            echo ":: Supported editors are listed below in between []. Value must be in lower case"
            ;;
        esac
      done

      echo && echo ":: Applying user settings..."
      setOption hostname $hostname
      setOption username $username
      # sed -i "0,/bart/s//$username/" $SCRIPT_DIR/flake.nix
      # setOption name $name
      sed -i "0,/Bart/s//$name/" $SCRIPT_DIR/flake.nix
      setOption email $email
      # sed -i "0,/contact@bartvegter.com/s//$email/" $SCRIPT_DIR/flake.nix
      echo && echo ":: Applied user settings"
      break
      ;;

    "N" | "n")
      echo && echo ":: Applying system defaults..."
      setOption hostname $(hostname)
      setOption username $(whoami)
      # sed -i "0,/bart/s//$(whoami)/" $SCRIPT_DIR/flake.nix
      # setOption name $(getent passwd $(whoami) | cut -d ':' -f 5 | cut -d ',' -f 1)
      sed -i "0,/Bart/s//$(getent passwd $(whoami) | cut -d ':' -f 5 | cut -d ',' -f 1)/" $SCRIPT_DIR/flake.nix
      setOption email ""
      # sed -i "s/contact@bartvegter.com//" $SCRIPT_DIR/flake.nix
      echo && echo ":: Applied system defaults"
      break
      ;;

    *)
      echo ":: Invalid input, please try again..." && echo
      echo ":: Valid values are [Y]es or [n]o (case insensitive), or press [return] for default (Yes)"
      ;;
  esac
done

gitAdd

if [ "$editor" == "nvim" ] || [ "$editor" == "vim" ]; then
  EDITOR=vim;
else
  EDITOR=nano;
fi

# Open up editor to manually edit flake.nix before install
echo
while true; do
  read -p ">> Would you like to manually edit flake.nix for further configuration? [y/N]: " ynManual
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
      echo ":: Valid values are [y]es or [N]o (case insensitive), or press [return] for default (No)"
      ;;
  esac
done

# Permissions for files that should be owned by root
# sudo $SCRIPT_DIR/harden.sh $SCRIPT_DIR;

echo && echo ":: Starting system configuration rebuild..." && echo

# Rebuild system
sudo nixos-rebuild --no-write-lock-file switch --flake $SCRIPT_DIR#system;

gitAdd

echo && echo ":: System configuration rebuild complete"
echo && echo ":: Starting home configuration rebuild..." && echo

# Install and build home-manager configuration
nix run home-manager/master --extra-experimental-features 'nix-command flakes' --no-write-lock-file -- switch --flake $SCRIPT_DIR#user;

gitAdd

echo && echo ":: Home configuration rebuild complete"


# Prompt for rebooting
echo && echo ":: Hyprnix installed successfully" && echo

while true; do
  read -p ">> Would you like to reboot into Hyprland? [Y/n]: " ynReboot
  case $ynReboot in
    "" | "Y" | "y")
      echo && echo ":: Rebooting system..."
      systemctl reboot
      break
      ;;

    "N" | "n")
      echo && echo ":: When ready, run 'systemctl reboot' to reboot into Hyprland"
      break
      ;;

    *)
      echo ":: Invalid input, please try again..." && echo
      echo ":: Valid values are [Y]es or [n]o (case insensitive), or press [return] for default (Yes)"
      break
      ;;
  esac
done

exit
