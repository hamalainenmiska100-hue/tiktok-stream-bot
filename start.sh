#!/bin/bash

RTMP_URL="rtmp://live.restream.io/live"
STREAM_KEY="re_11414527_eventd786409fc869479fb2a580026af0243c"

echo "🚀 käynnistyy..."

while true; do
  while read -r url; do

    [ -z "$url" ] && continue

    echo "⬇️ ladataan: $url"

    # lataa video temp tiedostoon
    curl -L --retry 5 --retry-delay 3 "$url" -o video.mp4

    echo "▶️ striimataan..."

    ffmpeg -re \
    -stream_loop -1 \
    -i video.mp4 \
    -vf "scale=1920:1080:force_original_aspect_ratio=decrease,\
pad=1920:1080:(ow-iw)/2:(oh-ih)/2,fps=60" \
    -c:v libx264 -preset veryfast \
    -b:v 4500k -maxrate 5000k -bufsize 9000k \
    -pix_fmt yuv420p \
    -r 60 \
    -g 120 \
    -c:a aac -b:a 160k \
    -f flv "$RTMP_URL/$STREAM_KEY"

    echo "🧹 poistetaan tiedosto"
    rm -f video.mp4

    echo "⚠️ valmis → seuraava"
    sleep 2

  done < videos.txt
done
