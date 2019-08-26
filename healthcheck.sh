#!/bin/bash
set -Eeuo pipefail

if [ $(supervisorctl status | grep RUNNING | wc -l ) == 1 ]; then
    echo "Bird process is live"
else
    # the world is on fire!
    exit 1
fi


