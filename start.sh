#!/bin/sh

RTMP_URL="rtmp://live.restream.io/live"
STREAM_KEY="re_11414527_eventd786409fc869479fb2a580026af0243c"

echo "🚀 käynnistyy..."

while true; do
  while read -r url; do

    if [ -z "$url" ]; then
      continue
    fi

    echo "▶️ $url"

    ffmpeg -re \
    -reconnect 1 -reconnect_streamed 1 -reconnect_delay_max 5 \
    -i "$url" \
    -vf "scale=1920:1080:force_original_aspect_ratio=decrease,\
pad=1920:1080:(ow-iw)/2:(oh-ih)/2,fps=60" \
    -c:v libx264 -preset veryfast -profile:v high -level 4.2 \
    -b:v 4500k -maxrate 5000k -bufsize 9000k \
    -pix_fmt yuv420p \
    -r 60 \
    -g 120 \
    -c:a aac -b:a 160k \
    -f flv "${RTMP_URL}/${STREAM_KEY}"

    echo "⚠️ valmis / error → seuraava"
    sleep 2

  done < videos.txt
done
