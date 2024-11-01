#!/bin/sh

set -e

HOSTARCH="x86_64"
XBPS="$PWD/XBPS"

BUILDDIR="$PWD/build"

if [ "$1" =  "clean ]; then
    rm -rf "$XBPS"
    rm -rf "$BUILDDIR"
    exit 0
fi

if [ -x "$XBPS/usr/bin/xbps-install" ]; then
    2>&1 echo "Found xbps-install at $XBPS/usr/bin/xbps-install, not setting up xbps.
    2>&1 echo "Exiting 0..."
    exit 0
fi

mkdir -p "$XBPS"
mkdir -p "$BUILDDIR"

wget -P "$BUILDDIR" "http://repo-default.voidlinux.org/static/xbps-static-latest.$HOSTARCH-musl.tar.xz"
tar xvf "$BUILDDIR/xbps-static-latest.$HOSTARCH-musl.tar.xz" -C "$XBPS"

export PATH="$XBPS/usr/bin:$PATH"

echo "xbps ($(which xbps-install)) installed in PATH" >&2
