FROM alpine:3.8

RUN apk add --no-cache shadow transmission-daemon && \
    usermod -s /bin/sh transmission

EXPOSE 9091
EXPOSE 51413

COPY settings.json /etc/transmission-daemon/settings.json
COPY run.sh /usr/bin/transmission.sh

CMD ["/usr/bin/transmission.sh"]
