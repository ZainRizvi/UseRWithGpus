#!/bin/bash

function install_pip_package() {
    pip install --upgrade --upgrade-strategy only-if-needed --force-reinstall "$@" || exit 1
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
install_pip_package rpy2==3.0.5 # Code in both Python & R at the same time
