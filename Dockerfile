FROM alpine:3.11.5 as builder
ENV RELEASE_REVISION=44fc571a67
ENV RELEASE_URL=https://build.transmissionbt.com/job/trunk-linux/lastBuild/artifact/transmission-master-r${RELEASE_REVISION}.tar.xz

RUN apk add --no-cache curl-dev libevent-dev openssl-dev git tar xz g++ make && \
    mkdir -p /tmp/src /tmp/build/usr && \
    cd /tmp/src && \
    wget "$RELEASE_URL" && \
    xz -d transmission-master-r${RELEASE_REVISION}.tar.xz && \
    tar -xf transmission-master-r${RELEASE_REVISION}.tar -C . && \
    cd "/tmp/src/transmission-3.00+" && \
    ./configure --enable-daemon --without-gtk --disable-cli --disable-mac --disable-nls --prefix=/tmp/build/usr && \
    make && \
    make install

FROM alpine:3.11.5
COPY --from=builder /tmp/build /
RUN apk add --no-cache libevent libcurl && \
    adduser -D transmission
USER transmission
WORKDIR /home/transmission
RUN mkdir -p /home/transmission/config /home/transmission/downloads
EXPOSE 9091
EXPOSE 51413
CMD ["/usr/bin/transmission-daemon", "--foreground", "--log-error", "--config-dir", "/home/transmission/config"]
