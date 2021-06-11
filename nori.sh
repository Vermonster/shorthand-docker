#!/usr/bin/env bash

docker run -p 2021:2021 -it -v "$(pwd)":/workspace shorthand "$@"
