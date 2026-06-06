#!/usr/bin/env bash
# Open Brave on Alt+B, but forward the shortcut in text-editing contexts.

class=$(hyprctl activewindow -j | jq -r '.class // empty')

TERMINAL_PATTERN='^(kitty|foot|Alacritty|org\.wezfurlong\.wezterm|nvim|neovide|Emacs|emacs)$'
TEXT_EDITING_PATTERN='^(kitty|foot|Alacritty|org\.wezfurlong\.wezterm|cursor|Cursor|code|Code|org\.gnome\.TextEditor|gedit|kate|org\.kde\.kwrite|nvim|neovide|Emacs|emacs|com\.github\.xoarnalp|brave-browser|Brave-browser|firefox|Firefox|Google-chrome|Chromium|chromium)$'

if [[ "$class" =~ $TEXT_EDITING_PATTERN ]]; then
    if [[ "$class" =~ $TERMINAL_PATTERN ]]; then
        hyprctl dispatch sendshortcut "ALT,b,activewindow"
    else
        hyprctl dispatch sendshortcut "CTRL,b,activewindow"
    fi
    exit 0
fi

exec brave
