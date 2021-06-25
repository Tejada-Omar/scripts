#!/bin/bash
choices="alacritty\ngtk-3.0\nmpv\nneofetch\nnvim\npicom\nqtile\nzathura"
chosen=$(echo -e "$choices" | dmenu -p "Choose config to edit:")

case "$chosen" in
    "alacritty") file="$HOME/.config/alacritty/alacritty.yml" ;;
    "gtk-3.0")   file="$HOME/.config/gtk-3.0/settings.ini" ;;
    "mpv")       file="$HOME/.config/mpv/mpv.conf" ;;
    "neofetch")  file="$HOME/.config/neofetch/config.conf" ;;
    "nvim")      file="$HOME/.config/nvim/init.vim" ;;
    "picom")     file="$HOME/.config/picom/picom.conf" ;;
    "qtile")     file="$HOME/.config/qtile/config.py" ;;
    "zathura")   file="$HOME/.config/zathura/zathurarc" ;;
esac

[[ -n "$chosen" ]] && "$TERM" -e "$EDITOR" "$file"
