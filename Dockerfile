FROM debian

RUN apt update && apt install wget -y && apt install unzip -y && apt install iputils-ping -y && apt install iproute2 -y && mkdir -p rathole/data && mkdir -p rathole/logs

COPY ./rathole/rathole /usr/local/bin/rathole
RUN chmod +x /usr/local/bin/rathole

ENV mode=


CMD ["sh", "-c", "rathole --$mode /rathole/config.toml >> /rathole/logs/rathole.log" ]
