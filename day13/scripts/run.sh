#!/bin/sh

set -e
cd "$(dirname "$0")"/..

java -jar build/lein/uberjar/day13-0.0.0-standalone.jar "${2}" < in/"${1}${2}.txt"
