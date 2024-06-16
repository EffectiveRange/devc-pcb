#!/bin/bash
set -e -x -o pipefail

pushd "$(dirname $0)/build" > /dev/null

git config --global user.email "devc@test.com"
git config --global user.name "Test Joe"

/usr/share/pcb-release/pcb-create-release -M -C ../pcb-micdevice
/usr/share/pcb-release/pcb-build ../pcb-micdevice