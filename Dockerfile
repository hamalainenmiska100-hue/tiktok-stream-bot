FROM jrottenberg/ffmpeg:6.0-ubuntu

RUN apt-get update && apt-get install -y curl

WORKDIR /app

COPY start.sh .
COPY videos.txt .

RUN chmod +x start.sh

CMD ["sh", "./start.sh"]
