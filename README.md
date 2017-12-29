# docker-emsdk
Docker files to build a emsdk docker image

## Build image

```
$ docker build -t docker-emsdk .
```

## Running

First create a volume to store the emscripten cache:
```
$ docker volume create emsdk_cache
```

Then run the container with the volume:
```
docker run --rm -it -v emsdk_cache:/root/.emscripten_cache docker-emsdk
```
