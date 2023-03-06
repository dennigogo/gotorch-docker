# gotorch-docker

## [go-bullseye-cuda117.Dockerfile](go-bullseye-cuda117.Dockerfile)
```bash
docker pull dennigogo/gotorch-docker:go-bullseye-cuda11.7
```

### Generic dependencies:
- docker image golang:bullseye
- https://github.com/wangkuiyi/gotorch (branch develop)
- https://github.com/opencv/opencv.git (branch 4.5.3)
- https://github.com/opencv/opencv_contrib.git (branch 4.5.3)
- LibTorch from https://download.pytorch.org/libtorch/cu117/libtorch-cxx11-abi-shared-with-deps-1.13.1%2Bcu117.zip
- CUDA 11.7 (cuda-repo-debian11-11-7-local_11.7.1-515.65.01-1_amd64.deb)

## [utils-bullseye-cuda117.Dockerfile](utils-bullseye-cuda117.Dockerfile)
```bash
docker pull dennigogo/gotorch-docker:utils-bullseye-cuda11.7
```

### Copy from dennigogo/gotorch-docker:go-bullseye-cuda11.7
- `/go/src/github.com/wangkuiyi/gotorch/cgotorch/libcgotorch.so`             => `/usr/lib/libcgotorch.so`
- `/go/src/github.com/wangkuiyi/gotorch/cgotorch/linux-cuda117/libtorch/lib` => `/usr/lib`
- `/opt/opencv/build/lib`                                                    => `/usr/lib`
- `/go/src/github.com/wangkuiyi/gotorch/resnet`                              => `/bin/resnet`

### Utils
- `/bin/resnet`