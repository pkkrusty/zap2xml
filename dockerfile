FROM alpine:3.13.5

ENV USERNAME=none
ENV PASSWORD=none
ENV XMLTV_FILENAME=xmltv.xml
ENV OPT_ARGS=
# wait 12 Hours after run
ENV SLEEPTIME=43200

RUN apk add --no-cache \
  perl \
  perl-http-cookies \
  perl-lwp-useragent-determined \
  perl-json \
  perl-json-xs \
  perl-lwp-protocol-https \
  perl-gd

VOLUME /data
ADD zap2xml.pl entry.sh /
CMD /entry.sh
