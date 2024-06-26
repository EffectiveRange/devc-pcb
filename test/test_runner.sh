#!/bin/bash
set -x -e -o pipefail

ROOT_DIR=$(dirname $(realpath $0))

IMAGE_ID=$1

pushd "$ROOT_DIR" > /dev/null

rm -rf pcb-micdevice build


# Running in docker already
if [ -z "$IMAGE_ID" ]; then
    su kicad -c "mkdir build"
    su  kicad -c "git clone --depth=1  https://github.com/EffectiveRange/pcb-micdevice.git"
    su  kicad -c /home/kicad/test/test.sh
else
mkdir build
git clone --depth=1  https://github.com/EffectiveRange/pcb-micdevice.git
docker run  --mount type=bind,source=$ROOT_DIR,target=/home/kicad/testproject  $IMAGE_ID /home/kicad/testproject/test.sh
fi




