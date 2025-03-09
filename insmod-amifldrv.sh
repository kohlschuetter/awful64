#!/bin/sh

cd "$(dirname $0)"

if [[ ! -d "DriverSource" ]]; then
  echo "DriverSource missing" >&2
  exit 1
fi

lsmod | grep -q amifldrv_
if [[ $? -eq 0 ]]; then
  echo "Already loaded"
  exit 0
fi

ok=
for ko in \
  DriverSource/amifldrv_impl.ko \
  DriverSource/amifldrv_mod.ko ; do
  echo $ko
  sudo insmod "$ko"
  if [[ $? -eq 0 ]]; then
    ok="Y$ok"
  fi
done

if [[ "$ok" != "YY" ]]; then
  echo "Could not load amifldrv kernel modules; please run ./build-DriverSource.sh" >&2
  exit 1
fi
