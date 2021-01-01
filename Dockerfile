FROM ubuntu:20.04
LABEL created by: Nithin C, 2020
ENV TZ=Europe/Warsaw

COPY ViennaRNA /ViennaRNA/
COPY NCodR /NCodR/
WORKDIR /ViennaRNA/

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apt update -y && apt upgrade -y && apt install --no-install-recommends -y python3 python3-pip \
    g++ make perl libgsl23 python libgsl-dev libmpfr-dev default-jdk libsvm-tools\
    && python3 -m pip install argparse \
    && dpkg -i *.deb \
    && apt -f install \
    && rm -rf /tmp/* /var/tmp/* /var/cache/apt/archives/* /var/lib/apt/lists/*  \
    && cd /NCodR \
    && rm -rf /ViennaRNA \
    && apt clean \
    && apt autoremove \
    && make \
    && cd /NCodR/model/ \
    && tar -xvf tsvm.model.tar.gz \
    && rm tsvm.model.tar.gz

ENV NCODR_HOME="/NCodR" 
WORKDIR /WORK
ENTRYPOINT ["/NCodR/NCodR.py"]
