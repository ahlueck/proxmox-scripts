#!/usr/bin/env sh
TMP=/tmp/npm_install.sh
URL=https://github.com/ahlueck/proxmox-scripts/raw/main/lxc/nginx-proxy-manager/install

if [ "$(uname)" != "Linux" ]; then
  echo "OS NOT SUPPORTED"
  exit 1
fi

DISTRO=$(cat /etc/*-release | grep -w ID | cut -d= -f2 | tr -d '"')
if [ "$DISTRO" != "alpine" ] && [ "$DISTRO" != "ubuntu" ] && [ "$DISTRO" != "debian" ]; then
  echo "DISTRO NOT SUPPORTED"
  exit 1
fi

INSTALL_SCRIPT=$DISTRO
if [ "$DISTRO" = "ubuntu" ]; then
  INSTALL_SCRIPT="debian"
fi

rm -rf $TMP
wget -O "$TMP" "$URL/$INSTALL_SCRIPT.sh"

chmod +x "$TMP"

if [ "$(command -v bash)" ]; then
  $(command -v sudo) bash "$TMP"
else
  sh "$TMP"
fi


