#!/usr/bin/env bash

while [ $($HOME/.config/hypr/scripts/sessions.sh wayland) ]; do

	spotifyctl="playerctl --player=spotify"
	player_status=$($spotifyctl status 2>/dev/null)

	if [ "$player_status" = "Playing" ]; then
		echo "  $($spotifyctl metadata artist) - $($spotifyctl metadata title)"
	elif [ "$player_status" = "Paused" ]; then
		echo "  $($spotifyctl metadata artist) - $($spotifyctl metadata title)"
	else
		echo ""
	fi

	sleep 0.1

done
