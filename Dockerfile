FROM jrottenberg/ffmpeg:6.0-alpine

WORKDIR /app

COPY videos.txt .
COPY start.sh .

RUN chmod +x start.sh

ENTRYPOINT []
CMD ["sh", "./start.sh"]
