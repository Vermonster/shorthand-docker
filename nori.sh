#!/usr/bin/env bash

docker run -e JAVA_OPTS='-Xmx2048m -Xms2048m' -p 2021:2021 -it -v "$(pwd)":/workspace shorthand "$@"
