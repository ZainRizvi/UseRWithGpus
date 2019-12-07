#!/bin/bash

apt install r-base -y

# Install IRkernel
Rscript -e "install.packages(c('repr', 'IRdisplay', 'IRkernel'), type = 'source', repos='http://cran.us.r-project.org')"

# Register IRkernel with Jupyter
Rscript -e "IRkernel::installspec(user = FALSE)"
