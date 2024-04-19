#!/usr/bin/env bash
# This script returns all active sessions shown in loginctl when not passing arguments.
# To check the activity of a certain session name, ex. wayland; pass the session name as the argument.

if [ -z $1 ]; then
	activeSessions=$(loginctl show-session $(awk '/tty/ {print $1}' <(loginctl)) -p Type | awk -F= '{print $2}')
else
	sessionTitle=$1
	activeSessions=$(loginctl show-session $(awk '/tty/ {print $1}' <(loginctl)) -p Type | awk -F= '{print $2}' | grep $sessionTitle)
fi

echo $activeSessions
