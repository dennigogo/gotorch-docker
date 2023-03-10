FROM debian:bullseye
COPY --from=dennigogo/gotorch-docker:go-bullseye-cuda11.7 /go/src/github.com/wangkuiyi/gotorch/cgotorch/libcgotorch.so /usr/lib/libcgotorch.so
COPY --from=dennigogo/gotorch-docker:go-bullseye-cuda11.7 /go/src/github.com/wangkuiyi/gotorch/cgotorch/linux-cuda117/libtorch/lib /usr/lib
COPY --from=dennigogo/gotorch-docker:go-bullseye-cuda11.7 /opt/opencv/build/lib /usr/lib
COPY --from=dennigogo/gotorch-docker:go-bullseye-cuda11.7 /go/src/github.com/wangkuiyi/gotorch/resnet /bin/resnet
COPY --from=dennigogo/gotorch-docker:go-bullseye-cuda11.7 /go/src/github.com/wangkuiyi/gotorch/tarball_divide /bin/tarball_divide
COPY --from=dennigogo/gotorch-docker:go-bullseye-cuda11.7 /go/src/github.com/wangkuiyi/gotorch/tarball_merge /bin/tarball_merge
