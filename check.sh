#!/bin/sh

set -e

cd "$(dirname "$0")"

export RUSTC_BOOTSTRAP=1

cd checker/
cargo build --quiet --out-dir ./build -Zunstable-options
cd ..

checker/build/checker "$@"
