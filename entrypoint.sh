#!/bin/bash
set -Eeuo pipefail

# Generate bird config
mo /etc/bird/bird.conf.mustache > /etc/bird/bird.conf

if [ "$1" == bird ] || [ "$1" == supervisor ] ; then
    /usr/lib/bird/prepare-environment
    /usr/sbin/bird -p
    # /usr/sbin/birdc configure
fi

exec "$@"
