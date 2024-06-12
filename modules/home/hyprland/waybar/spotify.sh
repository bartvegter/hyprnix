#!/usr/bin/env bash

while true; do

  spotifyctl="playerctl --player=spotify"
  playerStatus=$($spotifyctl status 2>/dev/null)

  if [[ "$playerStatus" == "Playing" ]]; then
    echo "  $($spotifyctl metadata artist) - $($spotifyctl metadata title)"
    elif [[ "$playerStatus" == "Paused" ]]; then
    echo "  $($spotifyctl metadata artist) - $($spotifyctl metadata title)"
  else
    echo ""
  fi

  sleep 0.1

done
