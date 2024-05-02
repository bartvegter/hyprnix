#!/usr/bin/env sh

if [[ $1 == "-a" ]] || [[ $1 == "--all" ]]; then
  echo && echo ":: Deleting all old profiles and store objects" && echo
  sudo nix-collect-garbage -d
  echo && echo ":: Cleaning up boot old entries" && echo
  sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system \
  && sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
else
  echo && echo ":: Deleting all profiles and store objects older than 2 weeks" && echo
  sudo nix-collect-garbage --delete-older-than 14d
fi
