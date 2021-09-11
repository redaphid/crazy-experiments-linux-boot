#!/usr/bin/env fish
docker build \
    --tag crazy-experiments-linux:builder \
    -f ./docker/builder.Dockerfile .; or exit 1 \
;

echo $PWD
docker run \
    --privileged \
    --mount type=bind,source=$PWD/scripts,target=/project/scripts \
    --mount type=bind,source=$PWD/tmp,target=/project/tmp \
    -it crazy-experiments-linux:builder /usr/bin/env fish -c 'cd /project; and fish'
