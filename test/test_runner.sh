#!/bin/bash
set -x -e -o pipefail

ROOT_DIR=$(dirname $(realpath $0))

IMAGE_ID=$1

pushd "$ROOT_DIR" > /dev/null

rm -rf pcb-micdevice build


# Running in docker already
if [ -z "$IMAGE_ID" ]; then
    GITHUB_TOKEN=$(cat /run/secrets/GITHUB_TOKEN)
    su kicad -c "mkdir build"
    su  kicad -c "git clone --depth=1  https://oauth2:$GITHUB_TOKEN@github.com/GlobalScope-HUN/pcb-micdevice.git"
    su  kicad -c /home/kicad/test/test.sh
else
mkdir build
git clone --depth=1  https://github.com/GlobalScope-HUN/pcb-micdevice.git
docker run  --mount type=bind,source=$ROOT_DIR,target=/home/kicad/testproject  $IMAGE_ID /home/kicad/testproject/test.sh
fi




