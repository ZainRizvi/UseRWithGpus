#!/bin/bash

while getopts m: option
do
case "${option}"
in
m) MODE=${OPTARG^};;
esac
done

if [ "${MODE}" = "GPU" ]; then
  Rscript -e  'library(keras); install_keras(tensorflow = "gpu")'
elif [ "${MODE}" = "CPU" ]; then
  Rscript -e  'library(keras); install_keras()'
else
    echo "Invalid mode specified!"
    exit 1
fi
