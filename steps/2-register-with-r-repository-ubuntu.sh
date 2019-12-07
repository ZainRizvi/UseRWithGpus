#!/bin/bash

# Install the lastest version of R from the offical Ubuntu repository
apt install apt-transport-https software-properties-common ocl-icd-opencl-dev -y
apt install dirmngr --install-recommends -y
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

# You may need to change the specific repository you use based on the
# version of Ubuntu you're running
# See https://cran.r-project.org/bin/linux/ubuntu/README.html#secure-apt for more details
add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/"

apt update
