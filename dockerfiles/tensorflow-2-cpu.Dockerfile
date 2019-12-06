FROM gcr.io/deeplearning-platform-release/tf2-cpu

LABEL maintainer="Zain  Rizvi"

RUN apt update -y 
# Add R support
RUN wget -O - https://raw.githubusercontent.com/ZainRizvi/UseRWithGpus/master/install-r-cpu-ubuntu.sh | bash
