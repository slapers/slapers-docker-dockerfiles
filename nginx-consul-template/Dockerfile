FROM nginx:1.9.4

MAINTAINER Stefan Lapers stefan@lapers.be

RUN \
  deps='curl' \
  && CONSULTEMPLATE_VERSION=0.10.0 \
  && CONSULTEMPLATE_SHA=606678dfe2a50b06c10d5d3872b31e7495f5e8da \
  \
  && echo " ------ GETTING DEPENDENCIES ------" \
  && apt-get update && apt-get install -y --no-install-recommends $deps \
  \
  && echo " ------ GETTING BINARIES ------" \
  && mkdir /tmp/src \
  && curl -L https://github.com/hashicorp/consul-template/releases/download/v${CONSULTEMPLATE_VERSION}/consul-template_${CONSULTEMPLATE_VERSION}_linux_amd64.tar.gz -o /tmp/src/consul-template.tar.gz \
  \
  && echo " ------ CHECKING INTEGRITY ------" \
  && echo "${CONSULTEMPLATE_SHA}  /tmp/src/consul-template.tar.gz" >> /tmp/src/sha1check \
  && sha1sum -c /tmp/src/sha1check \
  \
  && echo " ------ SETTING UP CONSULTEMPLATE ------" \
  && tar /tmp/src/consul-template.tar.gz --strip-components=1 -C /usr/bin --touch && \
  && mkdir -p /etc/consul-template/templates \
  && ln -sf /dev/stdout /var/log/consul-template.log \
  \
  && echo " ------ CLEANUP ------" \
  && rm -rf /var/lib/apt/lists/* \
            /tmp/* \
            /var/tmp/* \
            /tmp/src \
            
            
ADD entrypoint.sh /entrypoint.sh
ADD consul-template.cfg /etc/consul-template/config.cfg
ADD templates/ /etc/consul-template/templates/

EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]