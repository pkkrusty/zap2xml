FROM alpine:3

ENV USERNAME=none
ENV PASSWORD=none
ENV XMLTV_FILENAME=xmltv.xml
ENV OPT_ARGS=
# wait 12 Hours after run
ENV SLEEPTIME=43200

RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    echo '@edgetesting http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk add --no-cache \
        ca-certificates@edge \
        perl@edge \
        perl-html-parser@edge \
        perl-http-cookies@edge \
        perl-io-socket-ssl@edge \
        perl-json@edge \
        perl-json-xs@edge \
        perl-libwww@edge \
        perl-lwp-protocol-https@edge \
        perl-lwp-useragent-determined@edge \
        perl-mozilla-ca@edge \
        perl-net-http@edge \
        perl-net-libidn@edge \
        perl-net-ssleay@edge \
        perl-uri@edge

VOLUME /data
ADD zap2xml.pl entry.sh /
CMD /entry.sh
