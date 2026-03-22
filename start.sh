#!/bin/bash

STREAM_KEY="rtmp://live.restream.io/live/YOUR_STREAM_KEY"

echo "🚀 Stream bot käynnistyy..."

while true; do
  while read -r url; do

    if [ -z "$url" ]; then
      continue
    fi

    echo "▶️ $url"

    ffmpeg -re \
    -reconnect 1 -reconnect_streamed 1 -reconnect_delay_max 5 \
    -i "$url" \
    -c:v libx264 -preset veryfast -b:v 2500k \
    -c:a aac -b:a 128k \
    -f flv "$STREAM_KEY"

    echo "⚠️ valmis / error → seuraava"
    sleep 2

  done < videos.txt
done
