FROM jrottenberg/ffmpeg:6.0-alpine

WORKDIR /app

# Python + build tools + native deps streamlinkin riippuvuuksille
RUN apk add --no-cache \
    python3 \
    py3-pip \
    python3-dev \
    build-base \
    libxml2-dev \
    libxslt-dev \
    libffi-dev \
    openssl-dev \
    cargo \
    rust

# Päivitä pip-työkalut ja asenna streamlink
RUN pip3 install --no-cache-dir --upgrade pip setuptools wheel && \
    pip3 install --no-cache-dir --prefer-binary "streamlink<7"

# Kopioi appin tiedostot
COPY videos.txt .
COPY start.sh .

# Tee scriptistä ajettava
RUN chmod +x start.sh

# Poista ffmpeg-imagen oletus entrypoint
ENTRYPOINT []

# Käynnistys
CMD ["sh", "./start.sh"]
