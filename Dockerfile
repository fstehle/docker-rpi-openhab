FROM fstehle/rpi-java:8

RUN [ "cross-build-start" ]

RUN apt-get update && \
    apt-get -yq upgrade && \
    apt-get install -yq \
            unzip \
            supervisor \
            wget

ENV OPENHAB_VERSION 1.8.1

ADD pipework.sh /usr/local/bin/pipework
ADD supervisord.conf /etc/supervisor/supervisord.conf
ADD openhab.conf /etc/supervisor/conf.d/openhab.conf
ADD boot.sh /usr/local/bin/boot.sh
ADD openhab-restart.sh /etc/network/if-up.d/openhab-restart
ADD download_openhab.sh /root/download_openhab.sh

RUN mkdir -p /opt/openhab/logs

RUN /root/download_openhab.sh

RUN [ "cross-build-end" ]

EXPOSE 8080 8443 5555 9001

CMD ["/usr/local/bin/boot.sh"]
