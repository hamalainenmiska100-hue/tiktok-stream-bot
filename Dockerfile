FROM jrottenberg/ffmpeg:6.0-alpine

WORKDIR /app

COPY . .

RUN chmod +x start.sh

CMD ["./start.sh"]
