#!/bin/bash

while getopts m: option
do
case "${option}"
in
m) MODE=${OPTARG^};;
esac
done

IF $MODE

# Install R packages

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
)

install_r_packages "${OTHER_PACKAGES[@]}"

if [ "${MODE}" = "GPU" ]; then
  MODE_SPECIFIC_PACKAGES=( \
   # 'gpuR' \ # Installation fails witht the error ": ViennaCL: FATAL ERROR: ViennaCL encountered an unknown OpenCL error. Most likely your OpenCL SDK or driver is not installed properly."
  )
elif [ "${MODE}" = "CPU" ]; then
  MODE_SPECIFIC_PACKAGES=( \
   'xgboost' \
  )
else
    echo "Invalid mode specified!"
    exit 1
fi

install_r_packages "${MODE_SPECIFIC_PACKAGES[@]}"

# Setup the default location for user-installed packages
#
# Set the environment variable manually and...
export R_LIBS_USER=~/.R/library

# Set it in profile.d so it persists on the next start
# (this may not actually be needed)
export R_LIB_SETUP="/etc/profile.d/r_user_lib.sh"
cat << 'EOF' > "$R_LIB_SETUP"
export R_LIBS_USER=~/.R/library

# Ensure this directory exists at startup.  It needs to be in a persistent,
# user writable location.
mkdir -p "${R_LIBS_USER}"
EOF

chmod +x "${R_LIB_SETUP}"
