#!/usr/bin/env sh

hyprDir=$HOME/.config/hypr

hyprpaper=$hyprDir/hyprpaper.conf
hyprpaperTmp=$hyprDir/scripts/wallpaper/hyprpaper.conf.tmp

hyprIcon=$hyprDir/scripts/wallpaper/hyprlandIcon.png

cp -f $hyprpaper $hyprpaperTmp

# While loop checks for an active session in the environment variable $XDG_CURRENT_DESKTOP. This variable gets set automatically when using the Home Manager Hyprland module.
while [[ -z $XDG_CURRENT_DESKTOP ]]; do

  if [[ $(diff $hyprpaper $hyprpaperTmp) ]]; then
    cp -f $hyprpaper $hyprpaperTmp \
      && killall hyprpaper && hyprctl dispatch exec hyprpaper \
      && notify-send --app-name="hyprpaper" --icon=$hyprIcon "Hyprpaper" "Wallpaper loaded successfully"
  fi

  sleep 1
done
