FROM jrottenberg/ffmpeg:6.0-ubuntu

RUN apt-get update && apt-get install -y wget

WORKDIR /app

COPY start.sh .
COPY videos.txt .

RUN chmod +x start.sh

ENTRYPOINT []
CMD ["sh", "./start.sh"]
