#!/usr/bin/env bash

killall .waybar-wrapped && hyprctl dispatch exec waybar
