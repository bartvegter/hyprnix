#!/usr/bin/env sh

killall .waybar-wrapped && hyprctl dispatch exec .waybar-wrapped
