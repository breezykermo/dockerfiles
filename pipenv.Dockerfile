FROM ubuntu:18.04

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

# -- Install Pipenv and other essentials:
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y zlib1g-dev && \
    apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev python3-distutils && \
    apt-get install python3.7-dev -y && \
    apt-get install -y curl && \
    apt-get install -y git-core && \
    apt-get install -y vim
RUN curl --silent https://bootstrap.pypa.io/get-pip.py | python3.7

# Backwards compatility.
RUN rm -fr /usr/bin/python3 && ln /usr/bin/python3.7 /usr/bin/python3

RUN pip3 install pipenv

# -- Install Application into container:
RUN set -ex && mkdir /code

WORKDIR /code

# -- Adding Pipfiles
# ONBUILD COPY Pipfile Pipfile
# ONBUILD COPY Pipfile.lock Pipfile.lock
#
# # -- Install dependencies:
# ONBUILD RUN set -ex && pipenv install --deploy --system
