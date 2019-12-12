FROM gcr.io/deeplearning-platform-release/tf2-gpu
LABEL maintainer="Zain  Rizvi"

RUN apt update -y

RUN mkdir steps
COPY steps/* /steps/
RUN chmod +x /steps/*

RUN /steps/1-Install-generic-dependencies.sh
RUN /steps/2-register-with-r-repository-ubuntu.sh
RUN /steps/3-Install-R-and-IRkernel.sh
RUN /steps/4-Install-common-R-packages.sh -m GPU
RUN /steps/5-Add-rpy2-support.sh
RUN /steps/6-Compile-xgboost-gpu.sh
RUN /steps/7-Install-keras.sh -m GPU
