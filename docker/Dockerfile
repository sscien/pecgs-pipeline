FROM ubuntu:18.04

RUN apt-get update && apt-get install -y vim wget curl git

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py37_4.8.3-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p /miniconda
ENV PATH="/miniconda/bin:$PATH"

# get env file seperately so it doesn't reinstall every time
COPY ./env.yaml /pecgs-pipeline/env.yaml
RUN conda env create --file /pecgs-pipeline/env.yaml 

COPY . /pecgs-pipeline

ENV PATH="/miniconda/envs/pecgs/bin:$PATH"

# random string to force rebuild from here
RUN echo 'zazaagz'

# pip install -e git://github.com/{ username }/{ reponame }.git@{ tag name }#egg={ desired egg name }

RUN pip install git+https://github.com/estorrs/wombat.git@bbaf8c82cfb829e24d2d8eb14f407ef03d9e4ce5

CMD /bin/bash
