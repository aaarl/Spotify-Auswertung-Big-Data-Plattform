FROM node:10-alpine
COPY package.json /source/
WORKDIR /source/
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
RUN npm install --save node-rdkafka
WORKDIR /source/
RUN npm install
COPY index.js /source/
EXPOSE 8080
CMD ["node", "index.js"]