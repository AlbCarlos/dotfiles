#!/bin/bash

logout="󰍃  Logout"
suspend="󰒲  Suspend"
reboot="󰑓  Reboot"
poweroff="󰐥  Power Off"

chosen=$(printf '%s\n' "$logout" "$suspend" "$reboot" "$poweroff" \
    | rofi -dmenu -p "⏻  Power" -theme ~/.config/rofi/powermenu.rasi)

case "$chosen" in
    "$logout")
        hyprctl dispatch exec hyprshutdown
        ;;
    "$suspend")
        systemctl suspend
        ;;
    "$reboot")
        hyprctl dispatch exec "hyprshutdown -t 'Restarting...' --post-cmd 'systemctl reboot'"
        ;;
    "$poweroff")
        hyprctl dispatch exec "hyprshutdown -t 'Shutting down...' --post-cmd 'systemctl poweroff'"
        ;;
esac
