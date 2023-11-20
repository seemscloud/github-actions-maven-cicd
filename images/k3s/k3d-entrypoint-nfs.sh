#!/bin/sh

set -o errexit
set -o nounset
set -o pipefail

( sleep 10 && \
  #/bin/rc-status > /tmp/rcstatus.moises && cat /tmp/rcstatus.moises && \
  /bin/rc-status ) &

( sleep 20 && \
  touch /run/openrc/softlevel && \
  /sbin/rc-service nfs start ) &

exec /bin/k3s "$@"