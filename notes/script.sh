#!/bin/bash

# Example output
# $ HIST 200
# % History of Writing
# % Mon, 13 Sept, 2021

help(){
cat << EOF
USAGE: notes-start [-h | --help] [-o | --output]
        [-c | --class] [-t | --topic]
EOF
}

TEMP=$(getopt -o hc:t:o:: -l help,class:,topic:,output:: -n 'notes' -- "$@")

if [ $? != 0 ]; then help; echo "Terminating...">&2 ; exit 1 ; fi

eval set -- "$TEMP"

FILE=/dev/stdout
CLASS="[INSERT CLASS HERE]"
TOPIC="[INSERT TOPIC HERE]"
while true; do
  case "$1" in
    -h | --help ) help; exit 0 ;;
    -c | --class ) CLASS=$2; shift 2 ;;
    -t | --topic ) TOPIC=$2; shift 2 ;;
    -o | --output ) [[ -z "$2" ]] && FILE=./notes.md || FILE="$2"; shift 2 ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if [[ -f "$FILE" && "$FILE" != /dev/stdout ]]; then
  CHOICE="n"
  read -rp "WARNING: The following process will overwrite a pre-existing \
version of $FILE! Would you like to continue? [y/n] (n): " CHOICE

  if [[ "$CHOICE" != "y" ]]; then echo "Terminating..." >&2 ; exit 1; fi
fi

echo -e "\$ $CLASS\n% $TOPIC\n% $(date +"%A, %B %-d, %Y")" > "$FILE"
