#!/usr/bin/env sh

# Automated script for installing my dotfiles on NixOS.
# Shout-out to @LibrePhoenix for showing how to set this up using a flake.

# Clone dotfiles
if [ $# -gt 0 ]
  then
    SCRIPT_DIR=$1
  else
    SCRIPT_DIR=~/.hyprnix
fi

nix-shell -p git --command "git clone https://github.com/bartvegter/hyprnix $SCRIPT_DIR"

# Generate hardware config for new system
sudo nixos-generate-config --show-hardware-config > $SCRIPT_DIR/system/hardware-configuration.nix

# Check if uefi or bios
if [ -d /sys/firmware/efi/efivars ]; then
    sed -i "0,/bootMode.*=.*\".*\";/s//bootMode = \"uefi\";/" $SCRIPT_DIR/flake.nix
else
    sed -i "0,/bootMode.*=.*\".*\";/s//bootMode = \"bios\";/" $SCRIPT_DIR/flake.nix
    grubDevice=$(findmnt / | awk -F' ' '{ print $2 }' | sed 's/\[.*\]//g' | tail -n 1 | lsblk -no pkname | tail -n 1 )
    sed -i "0,/grubDevice.*=.*\".*\";/s//grubDevice = \"\/dev\/$grubDevice\";/" $SCRIPT_DIR/flake.nix
fi

# Patch flake.nix with different username/name and remove email by default
sed -i "0,/bart/s//$(whoami)/" $SCRIPT_DIR/flake.nix
sed -i "0,/Bart/s//$(getent passwd $(whoami) | cut -d ':' -f 5 | cut -d ',' -f 1)/" $SCRIPT_DIR/flake.nix
sed -i "s/contact@bartvegter.com//" $SCRIPT_DIR/flake.nix

# Open up editor to manually edit flake.nix before install
if [ -z "$EDITOR" ]; then
    EDITOR=nano;
fi
$EDITOR $SCRIPT_DIR/flake.nix;

# Permissions for files that should be owned by root
# sudo $SCRIPT_DIR/harden.sh $SCRIPT_DIR;

# Rebuild system
sudo nixos-rebuild switch --flake $SCRIPT_DIR#hyprnix;

# Install and build home-manager configuration
nix run home-manager/master --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake $SCRIPT_DIR#bart;