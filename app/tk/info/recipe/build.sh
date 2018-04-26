#!/bin/bash

VER=$PKG_VERSION

if [ `uname` == Darwin ]; then
    AQUA='--enable-aqua=yes'
fi

cd unix
CFLAGS="${CFLAGS} -I$PREFIX/include" LDFLAGS="$LDFLAGS" ./configure --with-tcl=$PREFIX/lib $AQUA --prefix=$PREFIX
make
make install

cd $PREFIX
rm -rf man share

if [ `uname` == Linux ]; then
    pushd $PREFIX/lib
    ln -s libtk8.?.so libtk.so
    popd
fi
