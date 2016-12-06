FROM alpine:3.4

COPY ./bootstrap /usr/local/bin/hitch-start
CMD "/usr/local/bin/hitch-start"

RUN apk --update add build-base libev libev-dev automake openssl openssl-dev bash autoconf curl byacc flex && \
    cd /tmp && \
    curl -L https://api.github.com/repos/varnish/hitch/tarball/hitch-1.4.3 | tar xz && \
    cd varnish-hitch* && \
    ./bootstrap && \
    ./configure && \
    make && \
    make install && \
    adduser -h /var/lib/hitch -s /sbin/nologin -u 8379 -D hitch && \
    rm -rf /tmp/* && \
    apk del git build-base libev-dev automake autoconf openssl-dev flex byacc && \
    rm -rf /var/cache/apk/*

USER hitch
