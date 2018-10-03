# $ docker build -t hz18 --build-arg "requirements_file=/requirements-to-freeze.txt" .

# allow users to override base_image (for GPU version, different tf version, etc.)
ARG base_image=tensorflow/tensorflow:1.10.0
FROM $base_image

# install apt-get packages
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    curl \
    ca-certificates \
    gdb \
    gfortran \
    git \
    htop \
    libatlas-base-dev \
    libcurl3-dev \
    libfreetype6-dev \
    libjpeg-dev \
    liblapack-dev \
    libsnappy-dev \
    libpng12-dev \
    libyaml-0-2 \
    libzmq3-dev \
    python-opencv \
    pkg-config \
    software-properties-common \
    swig \
    vim \
    wget \
    zip \
    sudo \
    bzip2 \
    libx11-6 \
    zlib1g-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install the Google Cloud SDK, which gives us `gcloud`, `gsutil`, `bq`.
# See https://cloud.google.com/sdk/downloads#apt-get
RUN apt-get update && apt-get -y install apt-transport-https && \
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" \
        | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && \
    apt-get install -y google-cloud-sdk \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install pip packages
ARG requirements_file=requirements.txt
COPY $requirements_file /requirements.txt
RUN pip install --upgrade pip && \
    pip install -r /requirements.txt \
    && rm -r ~/.cache/pip

RUN pip install http://download.pytorch.org/whl/cpu/torch-0.4.1-cp27-cp27mu-linux_x86_64.whl
RUN pip install torchvision 

ENV TERM=xterm

CMD ["/bin/bash"]

