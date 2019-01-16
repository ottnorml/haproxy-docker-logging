FROM haproxy:alpine

LABEL maintainer="Meik Minks <mminks@inoxio.de>"

RUN set -exo pipefail \
    && apk add --no-cache \
        rsyslog \
    && apk del syslog-ng \
    && mkdir -p /etc/rsyslog.d \
    && touch /var/log/haproxy.log \
    && ln -sf /dev/stdout /var/log/haproxy.log \
    && mv /docker-entrypoint.sh /docker-entrypoint-original.sh

COPY docker-entrypoint.sh /
COPY rsyslog.conf /etc/rsyslog.d/
