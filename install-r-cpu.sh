#!/bin/bash

# Install R

#required by multiple popular R packages
apt update
apt install -y \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2 \
    libxml2-dev

# Install the lastest version of R from the offical repository
apt install apt-transport-https software-properties-common ocl-icd-opencl-dev -y
apt install dirmngr --install-recommends -y
apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'

add-apt-repository "deb http://cloud.r-project.org/bin/linux/debian stretch-cran35/"

apt install r-base -y

# Install IRkernel
Rscript -e "install.packages(c('repr', 'IRdisplay', 'IRkernel'), type = 'source', repos='http://cran.us.r-project.org')"

# Register IRkernel with Jupyter
Rscript -e "IRkernel::installspec(user = FALSE)"

# Install various R packages

function install_r_package() {
    PACKAGE="${1}"
    echo "installing ${PACKAGE}"
    Rscript -e "install.packages(c('${PACKAGE}'))"
    # install.packages always returns 0 code, even if install actually failed
    echo "validating install of  ${PACKAGE}"
    Rscript -e "library('${PACKAGE}')"
    if [[ $? -ne 0 ]]; then
        echo "R package ${PACKAGE} failed to install."
        exit 1
    fi
}

function install_r_packages() {
    PACKAGES=(${@})
    for PACKAGE in "${PACKAGES[@]}"; do
        install_r_package "${PACKAGE}"
    done
}

# Install google specific packages
CLOUD_PACKAGES=( \
  'cloudml' \
  'bigrquery' \
  'googleCloudStorageR' \
  'googleComputeEngineR' \
  'googleAuthR' \
  'googleAnalyticsR' \
  'keras' \
)
install_r_packages "${CLOUD_PACKAGES[@]}"

# Install other packages
 OTHER_PACKAGES=( \
   'tidyverse' \
   'httpuv' \
   'ggplot2' \
   'devtools' \
   'gpuR' \
   'xgboost' \
)

 install_r_packages "${OTHER_PACKAGES[@]}"

# Setup the default location for user-installed packages
export R_LIB_SETUP="/etc/profile.d/r_user_lib.sh"
cat << 'EOF' > "$R_LIB_SETUP"
export R_LIBS_USER=~/.R/library

# Ensure this directory exists at startup.  It needs to be in a persistent,
# user writable location.
mkdir -p "${R_LIBS_USER}"
EOF

chmod +x "${R_LIB_SETUP}"

function install_pip2_package() {
    pip2 install --upgrade --upgrade-strategy only-if-needed --force-reinstall "$@" || exit 1
}

function install_pip3_package() {
    pip3 install --upgrade --upgrade-strategy only-if-needed --force-reinstall "$@" || exit 1
}

function install_pip_package() {
    install_pip2_package "$1"
    install_pip3_package "$1"
}

# Install rpy2

# To invoke R code in a python notebook, run the following code in a cell:
#   import rpy2.robjects as robjects
#   import rpy2.robjects.lib.ggplot2 as ggplot2
#   %load_ext rpy2.ipython
#
# Then you can use the %R and %%R magic commands to run R code

install_pip_package tzlocal # required by rpy2
# 3.0.5 is the last version that works with Python 3.5
install_pip3_package rpy2==3.0.5 # Code in both Python & R at the same time

# Reboot so that R user-installed packages path change takes effect
sudo reboot
