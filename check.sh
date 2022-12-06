#!/bin/sh

set -e

cd "$(dirname "$0")"

export RUSTC_BOOTSTRAP=1

if ! [ -x checker/build/checker ]; then
	cd checker/
	cargo build --quiet --out-dir ./build -Zunstable-options
	cd ..
fi

checker/build/checker "$@"
