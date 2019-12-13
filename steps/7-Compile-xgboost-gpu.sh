#!/bin/bash

# Install cmake (required to compile xgboost)
wget https://github.com/Kitware/CMake/releases/download/v3.16.0-rc2/cmake-3.16.0-rc2-Linux-x86_64.sh

chmod +x cmake-3.16.0-rc2-Linux-x86_64.sh
CMAKE_DIR=/opt/cmake-custom
mkdir $CMAKE_DIR
./cmake-3.16.0-rc2-Linux-x86_64.sh --skip-license --prefix=$CMAKE_DIR --exclude-subdir
rm cmake-3.16.0-rc2-Linux-x86_64.sh

ln -s $CMAKE_DIR/bin/* /usr/local/bin

# Install xgboost
cd
git clone --recursive https://github.com/dmlc/xgboost
cd xgboost
mkdir build
cd build
cmake -DUSE_CUDA=ON -DR_LIB=ON -DR_LIB=ON -DUSE_NCCL=ON -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-10.1 -DNCCL_ROOT=/usr/local/nccl2 ..

make -j4
make install
