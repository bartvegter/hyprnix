#!/usr/bin/env bash

hyprDir=$HOME/.config/hypr

hyprpaper=$hyprDir/hyprpaper.conf
hyprpaperTmp=$hyprDir/scripts/reloadhyprpaper/hyprpaper.conf.tmp

hyprIcon=$hyprDir/scripts/reloadhyprpaper/hyprlandIcon.png

cp -f $hyprpaper $hyprpaperTmp

# While loop checks for an active session titled "wayland"; should exit script after logout.
while [ $($hyprDir/scripts/sessions.sh wayland) ]; do

	if [[ $(diff $hyprpaper $hyprpaperTmp) ]]; then
		cp -f $hyprpaper $hyprpaperTmp \
		&& killall hyprpaper && hyprctl dispatch exec hyprpaper \
		&& notify-send --app-name="hyprpaper" --icon=$hyprIcon "Hyprpaper" "Wallpaper loaded successfully"
	fi

	sleep 1
done
