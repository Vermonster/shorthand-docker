#!/bin/bash
set -e

echo "**** su-exec dev $@ ..."

chown -R dev:dev /home/dev/.fhir

exec su-exec dev:dev "$@"
