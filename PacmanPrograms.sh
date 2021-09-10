#!/bin/bash
# Note that this script isn't actually useful and was written more as an exercise
# A better implementation would just be to add a pacman hook
tmpfile=$(mktemp /tmp/PacmanPrograms.XXXXXX)

# For writing to file
# Uses first file descriptor available
exec {FD_W}>"$tmpfile"
exec {FD_R}<"$tmpfile"

pacman -Qqe >&$FD_W
git diff --no-index "$HOME"/.pacmanprograms "$tmpfile"

# Deletes directory entry but leaves file open until all file descriptors are closed
rm "$tmpfile"

read -rp "Do you want to update .pacmanprograms with this? (Y/N): " answer

[ "${answer^^}" == "Y" ] &&
    cat <&$FD_R > "$HOME"/.pacmanprograms &&
    echo "Completed successfully."
