#!/bin/bash

# Example output
# $ HIST 200
# % History of Writing
# % Mon, 13 Sept, 2021

# Beginning function
# startnotes() {
#   head -n 5 "$1/notes.md" > ./notes.md
# }

TEMP=$(getopt -o h -l help -n 'notes' -- "$@")

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

eval set -- "$TEMP"

help(){
cat << EOF
USAGE: notes [-h | --help]
EOF
}

while true; do
  case "$1" in
    -h | --help ) help; shift ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done
