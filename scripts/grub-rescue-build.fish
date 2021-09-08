#!/usr/bin/env fish
docker build --tag crazy-experiments-linux:builder -f ./docker/builder.Dockerfile .; or exit 1
docker run \
    --mount type=bind,source=$PWD/scripts,target=/project/scripts \
    -it crazy-experiments-linux:builder /usr/bin/fish    
