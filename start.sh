#!/bin/sh

RTMP="rtmp://live.restream.io/live/re_11414527_eventd786409fc869479fb2a580026af0243c"

while true; do
  while read URL; do
    echo "Streaming $URL"

    streamlink -O "$URL" best | \
    ffmpeg -re -i pipe:0 \
      -vf "fps=60,scale=720:1280:force_original_aspect_ratio=decrease,\
pad=720:1280:(ow-iw)/2:(oh-ih)/2" \
      -c:v libx264 -preset veryfast -tune zerolatency \
      -b:v 2200k -maxrate 2200k -bufsize 4400k \
      -g 120 -pix_fmt yuv420p \
      -c:a aac -b:a 128k \
      -f flv "$RTMP"

    echo "Switching..."
    sleep 1
  done < videos.txt
done
