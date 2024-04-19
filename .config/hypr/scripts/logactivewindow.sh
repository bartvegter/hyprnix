#!/usr/bin/env bash

log=$HOME/activewindow.log

echo "@ $(date)" >> $log
hyprctl activewindow >> $log
