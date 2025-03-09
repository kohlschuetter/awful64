#!/bin/sh

if [[ -z "$1" ]]; then
  echo "Usage: $0 <path-to-kernel-source>" >&2
  exit 1
fi

sudo apk add alpine-sdk bison flex

make -C "$1" M="$(pwd)/DriverSource"
