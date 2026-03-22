#!/bin/bash

RTMP_URL="rtmp://live.restream.io/live"
STREAM_KEY="re_11414527_eventd786409fc869479fb2a580026af0243c"

echo "🚀 käynnistyy..."

while true; do
  while read -r url; do

    [ -z "$url" ] && continue

    echo "▶️ $url"

    ffmpeg -re \
    -user_agent "Mozilla/5.0" \
    -headers "Connection: keep-alive" \
    -reconnect 1 \
    -reconnect_streamed 1 \
    -reconnect_delay_max 10 \
    -rw_timeout 15000000 \
    -thread_queue_size 512 \
    -fflags +genpts+discardcorrupt \
    -i "$url" \
    -vf "scale=1920:1080:force_original_aspect_ratio=decrease,\
pad=1920:1080:(ow-iw)/2:(oh-ih)/2,fps=60" \
    -c:v libx264 -preset veryfast \
    -b:v 4500k -maxrate 5000k -bufsize 9000k \
    -pix_fmt yuv420p \
    -r 60 \
    -g 120 \
    -c:a aac -b:a 160k \
    -f flv "$RTMP_URL/$STREAM_KEY"

    echo "⚠️ valmis / error → seuraava"
    sleep 2

  done < videos.txt
done
