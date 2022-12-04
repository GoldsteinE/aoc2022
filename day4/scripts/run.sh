#!/bin/sh

set -e
cd "$(dirname "$0")"/..

PART="${2}" jq -sRf code/main.jq < "in/${1}${2}.txt"
