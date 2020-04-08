FROM ubuntu:18.04 as builder
ENV REPO_URL https://github.com/transmission/transmission
ENV REPO_COMMIT 20119f006c
RUN mkdir -p /build/usr /src
WORKDIR src
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential automake autoconf libtool pkg-config intltool \
    libcurl4-openssl-dev libglib2.0-dev libevent-dev libminiupnpc-dev git libssl-dev && \
    git clone "$REPO_URL" . && \
    git checkout "$REPO_COMMIT" && \
    git submodule update --init && \
    ./autogen.sh && \
    ./configure --enable-daemon --without-gtk --disable-cli --disable-mac --disable-nls --prefix /build/usr && \
    make && \
    make install && \
    mkdir -p /build/lib/x86_64-linux-gnu/ && \
    mkdir -p /build/usr/lib/x86_64-linux-gnu/ && \
    ldd /build/usr/bin/transmission-daemon | grep '=>' | awk '{ print $3 }' | xargs -I '{}' cp "{}" "/build{}"

FROM ubuntu:18.04
COPY --from=builder /build /
RUN useradd --create-home --user-group transmission
USER transmission
WORKDIR /home/transmission
RUN mkdir -p /home/transmission/config /home/transmission/downloads
EXPOSE 9091
EXPOSE 51413
CMD ["/usr/bin/transmission-daemon", "--foreground", "--log-error", "--config-dir", "/home/transmission/config"]
