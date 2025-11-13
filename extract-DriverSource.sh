#!/bin/sh

if [[ $(whoami) != "root" ]]; then
  echo "$0: Please run as root" >&2
  exit 1
fi

if [[ -z "$1" ]]; then
  echo "Syntax: $0 <path-to-AfuLnx64-directory>" >&2
  exit 1
fi

sudo apk add gcompat make alpine-sdk bison flex

afulnx="$1/afulnx_64"

dsDir=/lib/modules/awfulnx/build/DriverSource

renameUname=0
if [[ -f /usr/local/bin/uname ]]; then
  echo "Temporarily renaming /usr/local/bin/uname to /usr/local/bin/uname.orig"
  mv -f /usr/local/bin/uname /usr/local/bin/uname.orig
  renameUname=1
fi

cat >/usr/local/bin/uname <<EOT
#!/bin/sh

echo awfulnx
EOT

chmod 755 /usr/local/bin/uname
mkdir -p /lib/modules/awfulnx/build


TAB=$'\t'
cat >/lib/modules/awfulnx/build/Makefile <<EOT
all: modules

PHONY: all modules

modules:
${TAB}rm -rf "$dsDir"
${TAB}cp -av "\$(M)" "$dsDir"
EOT

chmod 755 "$afulnx"

"$afulnx" /MAKEDRV

if [[ $renameUname -eq 1 ]]; then
  mv -fv /usr/local/bin/uname.orig /usr/local/bin/uname
fi
