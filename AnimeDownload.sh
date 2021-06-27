#!/bin/bash
[[ -z "$1" || -z "$2"  || -z "$3" ]] &&
    echo "Insufficient Arguments" &&
    echo "AnimeDownload [lowerbound] [upperbound] [link] [true?]" &&
    exit 1

link=$3
[[ "${link:8:12}" != "v7.4animu.me" ]] &&
    echo "Incorrect Link" &&
    exit 1

lowerbound=$1
upperbound=$2
[[ ! "$lowerbound" -le "$upperbound" ]] &&
    echo "Bad bound arguments" &&
    echo "AnimeDownload [lowerbound] [upperbound] [link] [true?]" &&
    exit 1

directory=$(echo "$link" | cut -d '/' -f 4)
mkdir -p ~/Videos/Anime/"$directory"
cd ~/Videos/Anime/"$directory" || exit 1

episode=$(echo "$link" | cut -d '/' -f 5)
fieldnumber=$(echo "$episode" | grep -o - | wc -l)
for ((i=1; i < fieldnumber; i++))
do
    header=${header}$(echo "$episode" | cut -d '-' -f "$i")"-"
done

((++fieldnumber))
tail="-"$(echo "$episode" | cut -d '-' -f "$fieldnumber")

newlink="https://v7.4animu.me/$directory/"
for ((i=lowerbound; i <= upperbound; i++))
do
    if [ "$4" == true ] ; then
        if [ "$i" -le 9 ] ; then
            echo "EP-$i" "$newlink$header""0""$i$tail"
            youtube-dl -o "EP-$i" "$newlink$header""0""$i$tail"
        else
            echo "EP-$i" "$newlink$header$i$tail"
            youtube-dl -o "EP-$i" "$newlink$header$i$tail"
        fi
    else
        echo "EP-$i" "$newlink$header$i$tail"
        youtube-dl -o "EP-$i" "$newlink$header$i$tail"
    fi
done
