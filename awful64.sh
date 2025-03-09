#!/bin/sh

dn="$(dirname $0)"
if [[ ! -f "/AfuLnx64/AfuLnx64/afulnx_64" ]]; then
  echo "afulnx_64 binary not found"
  "$dn/prepare-DriverSource.sh"
fi

if [[ $(lsmod | grep -c amifldrv_) -ne 2 ]]; then
  echo "amifldrv kernel modules not loaded; trying to load" >&2 
  "$dn/insmod-amifldrv.sh"
fi

sudo ./AfuLnx64/AfuLnx64/afulnx_64 "$@"
