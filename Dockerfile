FROM alpine:latest
LABEL created by: Nithin C, 2020
ENV TZ=Europe/Warsaw
WORKDIR /NCodR/
ENV DEBIAN_FRONTEND noninteractive

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && apk update \
    && apk add --no-cache \
    make \
    git \
    g++ \
    gcc \
    python3 \
    py3-argparse \
    py3-pandas \
    wget \
    autoconf \
    automake \
    cmake \
    gengetopt \
    help2man \
    flex \
    swig \
    libtool \
    pkgconfig \
    gettext \
    file \
    python3-dev \
    perl \
    perl-dev \
    && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
    && git clone https://github.com/cjlin1/libsvm.git \
    && cd libsvm \
    && make \
    && cp svm-predict /bin/ \
    && cp svm-scale /bin/ \
    && cp svm-train /bin/ \
    && cd .. \
    && rm -rf libsvm \
    && wget https://www.tbi.univie.ac.at/RNA/download/sourcecode/2_5_x/ViennaRNA-2.5.0.tar.gz \
    && tar -zxvf ViennaRNA-2.5.0.tar.gz \
    && cd ViennaRNA-2.5.0 \
    && bash ./configure --without-kinfold --without-forester --without-python2 -without-gsl \
    --without-json --without-doc --without-tutorial --without-cla --without-check \
    --without-rnalocmin --without-svm --disable-mpfr \
    && make -j \
    && make install \
    && cd .. \
    && rm ViennaRNA-2.5.0.tar.gz \
    && rm -rf ViennaRNA-2.5.0 \
    && git clone https://gitlab.com/sunandanmukherjee/ncodr.git \
    && cd ncodr \
    && make \
    && rm -rf .git \
    && cd models \
    && tar -xvf models.tar.gz \
    && rm models.tar.gz \
    && apk del \
    make \
    git \
    wget \
    autoconf \
    automake \
    cmake \
    gengetopt \
    help2man \
    flex \
    swig \
    libtool \
    pkgconfig \
    gettext \
    file \
    && rm -rf /var/cache/apk/*

ENV PATH="/NCodR/ncodr:${PATH}"
ENV PYTHONPATH=/usr/local/lib/python3.9/site-packages:$PYTHONPATH
ENV NCODR_HOME="/NCodR/ncodr"
WORKDIR /WORK
ENTRYPOINT ["/NCodR/ncodr/NCodR.py"]
