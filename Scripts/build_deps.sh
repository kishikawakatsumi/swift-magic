#!/bin/sh
set -ex

SCRIPT_DIR=`dirname "$0"`

TDIR=`mktemp -d`
trap "{ cd - ; rm -rf $TDIR; exit 255; }" SIGINT

cd $TDIR

git clone https://github.com/file/file src

CURRENTPATH=`pwd`

TARGETDIR_MACOSX="$CURRENTPATH/.build/macosx"
mkdir -p "$TARGETDIR_MACOSX"
TARGETDIR_IPHONEOS="$CURRENTPATH/.build/iphoneos"
mkdir -p "$TARGETDIR_IPHONEOS"
TARGETDIR_IPHONESIMULATOR="$CURRENTPATH/.build/iphonesimulator"
mkdir -p "$TARGETDIR_IPHONESIMULATOR"

(cd src && autoreconf -if)
(cd src && ./configure --prefix="$TARGETDIR_MACOSX" --disable-shared --enable-static CFLAGS="-mmacosx-version-min=10.9" CXXFLAGS="-mmacosx-version-min=10.9" && make install)
(cd src && ./configure --prefix="$TARGETDIR_IPHONEOS" --disable-shared --enable-static --host=arm-apple-darwin CC=`xcrun -find clang` CFLAGS="-O3 -arch armv7 -arch armv7s -arch arm64 -isysroot `xcrun -sdk iphoneos --show-sdk-path` -fembed-bitcode -mios-version-min=8.0" CXX=`xcrun -find clang++` CXXFLAGS="-O3 -arch armv7 -arch armv7s -arch arm64 -isysroot `xcrun -sdk iphonesimulator --show-sdk-path` -fembed-bitcode -mios-version-min=8.0" && make install)
(cd src && ./configure --prefix="$TARGETDIR_IPHONESIMULATOR" --disable-shared --enable-static --host=x86_64-apple-darwin CC=`xcrun -find clang` CFLAGS="-O3 -arch i386 -arch x86_64 -isysroot `xcrun -sdk iphonesimulator --show-sdk-path` -fembed-bitcode-marker -mios-simulator-version-min=8.0" CXX=`xcrun -find clang++` CXXFLAGS="-O3 -arch i386 -arch x86_64 -isysroot `xcrun -sdk iphoneos --show-sdk-path` -fembed-bitcode-marker -mios-simulator-version-min=8.0" && make install)

cd -

mkdir -p "$SCRIPT_DIR/../Vendor/magic/include"
mkdir -p "$SCRIPT_DIR/../Vendor/magic/lib"
mkdir -p "$SCRIPT_DIR/../Vendor/magic/share"

cp -rf "$TARGETDIR_MACOSX/include" "$SCRIPT_DIR/../Vendor/magic/"
cp -rf "$TARGETDIR_MACOSX/share/misc" "$SCRIPT_DIR/../Vendor/magic/share"

xcrun lipo -create "$TARGETDIR_IPHONEOS/lib/libmagic.a" \
                   "$TARGETDIR_IPHONESIMULATOR/lib/libmagic.a" \
                   -o "$SCRIPT_DIR/../Vendor/magic/lib/libmagic.a"

rm -rf $TDIR
