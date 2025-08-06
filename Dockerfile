FROM alpine
LABEL maintainer="Jaunger"

RUN apk update && apk add zip && mkdir -p rathole/data && mkdir -p rathole/logs

COPY ./rathole/rathole /usr/local/bin/rathole
RUN chmod +x /usr/local/bin/rathole

ENV mode=

CMD ["sh", "-c", "rathole --$mode /rathole/config.toml >> /rathole/logs/rathole.log" ]
