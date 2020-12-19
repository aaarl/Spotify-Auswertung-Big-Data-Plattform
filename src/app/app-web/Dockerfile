FROM node:10-alpine

# Copy package.json
COPY package.json /src/

# Set working directory
WORKDIR /src/

# Install dependecies for node-rdkafka
RUN apk --no-cache add \
    bash \
    g++ \
    ca-certificates \
    lz4-dev \
    musl-dev \
    cyrus-sasl-dev \
    openssl-dev \
    make \
    python

RUN apk add --no-cache --virtual .build-deps gcc zlib-dev libc-dev bsd-compat-headers py-setuptools bash

# Install node-rdkafka
RUN npm install --save node-rdkafka

# Installieren von npm
WORKDIR /src/
RUN npm install

# Copy web application
COPY index.js /src/

# Port 8080 freigeben
EXPOSE 8080

# Ausführen der datei index.js mit node
CMD ["node", "index.js"]