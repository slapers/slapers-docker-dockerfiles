#!/bin/bash

set -e

if [ -z "$TEMPLATES" ]
then
  echo "No templates specified in env to parse"
fi

for _TEMPLATE in $TEMPLATES
do
  echo "processing template: ${_TEMPLATE}"
  /usr/bin/perl -p -i -e 's/<\{([^}]+)\}>/defined $ENV{$1} ? $ENV{$1} : $&/eg' ${_TEMPLATE}
  echo "---------------------------------"
  cat ${_TEMPLATE}
done


echo "Starting nginx"
echo "--------------"
/usr/sbin/nginx -g "daemon off;"