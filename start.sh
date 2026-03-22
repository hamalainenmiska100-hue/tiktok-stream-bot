#!/bin/bash

STREAM_KEY="rtmp://live.restream.io/live/YOUR_STREAM_KEY"
CHAT_URL="https://chat.restream.io/embed?token=cb87b406-5275-40f7-8039-84a62ad620b3"

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
    -f lavfi -i "color=c=black@0.0:s=1920x1080" \
    -filter_complex "\
[0:v]scale=1920:1080:force_original_aspect_ratio=decrease,\
pad=1920:1080:(ow-iw)/2:(oh-ih)/2,\
fps=60[base]; \
[1:v][base]overlay=0:0[tmp]; \
movie='${CHAT_URL}':loop=0,setpts=N/FRAME_RATE/TB,scale=600:-1[chat]; \
[tmp][chat]overlay=W-w-20:20" \
    -c:v libx264 -preset veryfast -profile:v high -level 4.2 \
    -b:v 4500k -maxrate 5000k -bufsize 9000k \
    -pix_fmt yuv420p \
    -r 60 \
    -g 120 \
    -c:a aac -b:a 160k \
    -f flv "$STREAM_KEY"

    echo "⚠️ valmis / error → seuraava"
    sleep 2

  done < videos.txt
done
