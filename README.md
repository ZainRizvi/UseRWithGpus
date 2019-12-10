# Use GPUs with R

These are the sample code and installer mentioned in my [GPU-Powered Computing for Data Science with R Notebooks on Google Cloud’s AI Platform Notebooks \[DC91511\]](https://events.rainfocus.com/widget/nvidia/gtcdc19/catalog-short?search=zain) talk [[recording](https://on-demand.gputechconf.com/gtcdc/2019/video/dc91511-gpu-powered-computing-for-data-science-with-r-notebooks-on-google-clouds-ai-platform/)] at Nvidia GTC 2019. The talk covered various ways to speed up your data analysis for AI and ML workflows, with a focus on optimizing GPU usage

This repository contains consists of installation scripts to easily install R on Jupyter Notebooks (like AI Platform Notebooks).

The notebooks contain code that shows how easy it is to perform various Machine Learning/Deep Learning actions on CPU based notebooks versus GPU based notebooks, and you can use the installation script to add R support to any of the existing AI Platform Notebooks

This blog post describes the installation script in more detail: https://zainrizvi.io/blog/using-gpus-with-r-in-jupyter-lab/

[Watch the talk here](https://on-demand.gputechconf.com/gtcdc/2019/video/dc91511-gpu-powered-computing-for-data-science-with-r-notebooks-on-google-clouds-ai-platform/)

[Slides are available here](https://github.com/ZainRizvi/UseRWithGpus/blob/master/Slides%20-%20R%20with%20GPU.pdf)

# Installation

To use the provided scripts on your AI Platform Notebooks, create a notebook VM and then run one of the below commands based on whether or not your notebook VM has GPUs attached. (Don't like running unknown code from the internet? I explain what they are doing [in this blog post](https://zainrizvi.io/blog/using-gpus-with-r-in-jupyter-lab/))

With CPUs only:
'sudo -- sh -c 'wget -O - https://raw.githubusercontent.com/ZainRizvi/UseRWithGpus/master/install-r-cpu.sh | bash'

With GPUs:
'sudo -- sh -c 'wget -O - https://raw.githubusercontent.com/ZainRizvi/UseRWithGpus/master/install-r-gpu.sh | bash'

Now, those scripts take a while to run.  Instead, you can just use the containerized versions of AI Platform Notebooks, which come with Tensorflow 2 support built in.

Here are their repositories on docker hub:

   * zainrizvi/deeplearning-container-tf2-with-r:latest-cpu
   * zainrizvi/deeplearning-container-tf2-with-r:latest-gpu

And you can use the above custom containers to have a notebook running on AI Platform Notebook in just a couple minutes!
