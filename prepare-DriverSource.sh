#!/bin/sh

cd "$(dirname $0)"
if [[ ! -d "AfuLnx64" ]]; then
  if [[ ! -f "Afulnx.zip" ]]; then
  wget "https://download.asrock.com/TSD/Afulnx.zip" || \
    wget "https://web.archive.org/web/20250306211050/https://download.asrock.com/TSD/Afulnx.zip"
  fi

  sudo apk add zip

  if [[ ! -f "Afulnx-fixed.zip" ]]; then
    yes | zip -FF --out Afulnx-fixed.zip Afulnx.zip
  fi
  unzip "Afulnx-fixed.zip"
fi

if [[ ! -d "DriverSource" ]]; then
  echo Extracting DriverSource from afulnx_64 ...
  echo This requires root, trying via sudo

  sudo ./extract-DriverSource.sh $(pwd)/AfuLnx64/
  cp -rv /lib/modules/awfulnx/build/DriverSource DriverSource

  echo Patching DriverSource...
  cd "DriverSource"
  cat ../amifldrv-vm_flags.patch | patch -p1
  cd ..
else
  echo "DriverSource directory already exists; assuming all good"
  echo "Delete $(pwd)/DriverSource to build again"
fi
