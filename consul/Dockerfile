FROM debian:jessie

MAINTAINER Stefan Lapers <stefan@lapers.be>

RUN \
  apt-get update && apt-get -y install curl unzip \
  && export CONSUL_VERSION=0.6.3 \
  && export CONSUL_CHECKSUM=b0532c61fec4a4f6d130c893fd8954ec007a6ad93effbe283a39224ed237e250 \
  && export CONSUL_UI_CHECKSUM=93bbb300cacfe8de90fb3bd5ede7d37ae6ce014898edc520b9c96a676b2bbb72 \
  && mkdir -p /tmp/src \
  \
  && echo " ------ GETTING BINARIES ------" \
  && curl -L https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o /tmp/src/consul_${CONSUL_VERSION}_linux_amd64.zip \
  && curl -L https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_web_ui.zip -o /tmp/src/consul_${CONSUL_VERSION}_web_ui.zip \
  \
  && echo " ------ CHECKING INTEGRITY ------" \
  && echo "${CONSUL_CHECKSUM}  /tmp/src/consul_${CONSUL_VERSION}_linux_amd64.zip" >> /tmp/src/sha1check \
  && echo "${CONSUL_UI_CHECKSUM}  /tmp/src/consul_${CONSUL_VERSION}_web_ui.zip" >> /tmp/src/sha1check \
  && sha256sum -c /tmp/src/sha1check \
  \
  && echo " ------ SETTING UP CONSUL ------" \
  && unzip /tmp/src/consul_${CONSUL_VERSION}_linux_amd64.zip -d /usr/bin \
  \
  && echo " ------ SETTING UP /UI ------" \
  && mkdir -p /ui \
  && unzip /tmp/src/consul_${CONSUL_VERSION}_web_ui.zip -d /ui \
  \
  && echo " ------ CLEANUP ------" \
  && rm -rf /var/lib/apt/lists/* \
            /tmp/* \
            /var/tmp/* \
            /tmp/src \
  && apt-get purge -y --auto-remove $deps
  
ENV GOMAXPROCS 2

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600 8600/udp

VOLUME [ "/config", "/data" ]

ENTRYPOINT [ "/usr/bin/consul" ]
CMD []
