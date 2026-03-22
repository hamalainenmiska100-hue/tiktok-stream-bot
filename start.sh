#!/bin/sh

RTMP="rtmp://live.restream.io/live/re_11414527_eventd786409fc869479fb2a580026af0243c"

while true; do
  while read URL; do
    echo "Streaming $URL"

    ffmpeg -re -i "$URL"       -c:v copy -c:a copy       -f flv "$RTMP" || \
    ffmpeg -re -i "$URL"       -c:v libx264 -preset ultrafast -b:v 1200k       -c:a aac -b:a 96k       -f flv "$RTMP"

    echo "Switching video..."
    sleep 2
  done < videos.txt
done
