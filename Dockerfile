FROM jrottenberg/ffmpeg:6.0-alpine

WORKDIR /app

# Asennetaan streamlink
RUN apk add --no-cache streamlink

# Kopioidaan tiedostot
COPY videos.txt .
COPY start.sh .

# Tehdään scriptistä ajettava
RUN chmod +x start.sh

# Poistetaan ffmpeg default entrypoint
ENTRYPOINT []

# Käynnistys
CMD ["sh", "./start.sh"]
