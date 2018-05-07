FROM debian:9.4

RUN apt-get update && \
    apt-get install -y transmission-daemon sudo && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    adduser transmission

EXPOSE 9091
EXPOSE 51413

COPY settings.json /etc/transmission-daemon/settings.json
COPY run.sh /usr/bin/transmission.sh

CMD ["/usr/bin/transmission.sh"]
