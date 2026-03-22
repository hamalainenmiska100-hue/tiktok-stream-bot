FROM jrottenberg/ffmpeg:6.0-alpine

WORKDIR /app

# kopioi kaikki tiedostot
COPY . .

# tee scriptistä ajettava
RUN chmod +x start.sh

# käynnistä scripti (EI ffmpeg suoraan!)
CMD ["bash", "./start.sh"]
