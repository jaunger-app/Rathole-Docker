FROM debian

RUN apt update && apt install wget -y && apt install unzip -y && apt install iputils-ping -y && apt install iproute2 -y && mkdir -p rathole/data 

COPY ./rathole/rathole /usr/local/bin/

ENV mode=


CMD ["sh", "-c", "rathole --$mode /rathole/config.toml"]
