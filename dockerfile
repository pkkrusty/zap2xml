FROM alpine:3
ARG DIGEST
ARG GIT_COMMIT
ARG URL
ARG VENDOR

LABEL org.opencontainers.image.base.digest="${DIGEST:-unknown}"
LABEL org.opencontainers.image.base.name="docker.io/library/alpine:3"
LABEL org.opencontainers.image.description="Contains the zap2xml Perl script, a command-line utility that extracts electronic program guide (EPG) data for over-the-air (OTA) or cable television from any one of several service providers, parses it, collates it, and saves it in a format compatible with various media center applications."
LABEL org.opencontainers.image.documentation="${URL:-unknown}"
LABEL org.opencontainers.image.licenses="GPL-3.0-or-later"
LABEL org.opencontainers.image.revision="${GIT_COMMIT:-unknown}"
LABEL org.opencontainers.image.source="${URL:-unknown}"
LABEL org.opencontainers.image.title="zap2xml"
LABEL org.opencontainers.image.url="${URL:-unknown}"
LABEL org.opencontainers.image.vendor="${VENDOR:-unknown}"

ENV USERNAME=none
ENV PASSWORD=none
ENV XMLTV_FILENAME=xmltv.xml
ENV OPT_ARGS=
# wait 12 Hours after run
ENV SLEEPTIME=43200

RUN echo '@edge https://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
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
