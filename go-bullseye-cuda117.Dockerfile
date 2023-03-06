FROM golang:bullseye

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y git cmake python3 clang unzip && apt clean

WORKDIR /opt

RUN git clone --depth 1 --branch 4.5.3 https://github.com/opencv/opencv.git && \
    git clone --depth 1 --branch 4.5.3 https://github.com/opencv/opencv_contrib.git && \
    cd opencv && \
    mkdir build && \
    cd build && \
    cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/ \
    -D PYTHON3_PACKAGES_PATH=/usr/lib/python3/dist-packages \
    -D WITH_V4L=ON \
    -D WITH_QT=OFF \
    -D WITH_OPENGL=ON \
    -D WITH_GSTREAMER=ON \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib/modules \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D INSTALL_C_EXAMPLES=OFF \
    -D BUILD_EXAMPLES=OFF .. && \
   make -j"$(nproc)" && \
   make install

WORKDIR /tmp

RUN apt install software-properties-common -y \
    && wget -q https://developer.download.nvidia.com/compute/cuda/11.7.1/local_installers/cuda-repo-debian11-11-7-local_11.7.1-515.65.01-1_amd64.deb \
    && dpkg -i cuda-repo-debian11-11-7-local_11.7.1-515.65.01-1_amd64.deb \
    && cp /var/cuda-repo-debian11-11-7-local/cuda-*-keyring.gpg /usr/share/keyrings/ \
    && add-apt-repository contrib \
    && apt update \
    && apt -y install cuda \
    && rm cuda-repo-debian11-11-7-local_11.7.1-515.65.01-1_amd64.deb

RUN apt clean

WORKDIR /go/src/github.com/wangkuiyi
RUN git clone --depth 1 --branch develop https://github.com/wangkuiyi/gotorch.git

WORKDIR /go/src/github.com/wangkuiyi/gotorch
RUN go mod download --json

WORKDIR /go/src/github.com/wangkuiyi/gotorch/cgotorch
ADD cgotorch/build.sh .
RUN ./build.sh

WORKDIR /go/src/github.com/wangkuiyi/gotorch
RUN go build -o resnet ./example/resnet