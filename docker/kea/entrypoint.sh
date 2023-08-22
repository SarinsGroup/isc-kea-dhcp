#!/bin/sh
set -e

echo "$(date) INFO: starting container kea-${KEA_SERVICE}"

exec /usr/local/sbin/kea-${KEA_SERVICE} -c etc/kea/kea-${KEA_SERVICE}.conf -d