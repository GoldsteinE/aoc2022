#!/bin/sh

set -e
cd "$(dirname "$0")"/../code

lein uberjar
