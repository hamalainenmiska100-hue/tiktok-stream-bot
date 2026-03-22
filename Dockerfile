FROM jrottenberg/ffmpeg:6.0-alpine

WORKDIR /app

# kopioi kaikki
COPY . .

# anna oikeudet
RUN chmod +x start.sh

# 💥 tämä poistaa ffmpeg entrypointin (TÄRKEIN)
ENTRYPOINT []

# käynnistä scripti oikein
CMD ["sh", "./start.sh"]
