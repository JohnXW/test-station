#! /bin/sh

BUILD_DIR="$1"

rm -r "$BUILD_DIR/dist"
rm -r "$BUILD_DIR/.cabal-sandbox/logs"
rm -r "$BUILD_DIR/.cabal-sandbox/share"
rm -r "$BUILD_DIR/.cabal-sandbox/packages"
rm -r "$BUILD_DIR"/.cabal-sandbox/*-packages.conf.d
rm -r "$BUILD_DIR/.cabal-sandbox/add-source-timestamps"
rm "$BUILD_DIR/.cabal-sandbox/bin/warp"
