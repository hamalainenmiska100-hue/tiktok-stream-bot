FROM jrottenberg/ffmpeg:6.0-alpine

WORKDIR /app

# Asennetaan python + pip
RUN apk add --no-cache python3 py3-pip

# Asennetaan streamlink pipillä
RUN pip3 install --no-cache-dir streamlink

# Kopioidaan tiedostot
COPY videos.txt .
COPY start.sh .

# Tehdään scriptistä ajettava
RUN chmod +x start.sh

# Poistetaan ffmpeg default entrypoint
ENTRYPOINT []

# Käynnistys
CMD ["sh", "./start.sh"]
