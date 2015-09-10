#!/bin/sh
nginx -c /config/nginx.conf

consul-template -config /etc/consul-template/config.cfg > /var/log/consul-template.log&
nginx -c /etc/nginx/nginx.conf -g "daemon off;"