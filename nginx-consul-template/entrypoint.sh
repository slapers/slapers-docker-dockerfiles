#!/bin/sh

consul-template -config /etc/consul-template/config.cfg > /var/log/consul-template.log&
nginx -c /etc/nginx/nginx.conf -g "daemon off;"
