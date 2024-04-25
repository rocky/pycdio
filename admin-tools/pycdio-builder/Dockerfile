# hadolint global ignore=DL3003

FROM quay.io/pypa/manylinux2014_x86_64:2024-04-23-ef7507e

RUN yum install -y swig-2.0.10-5.el7 && yum clean all

WORKDIR /tmp/

ADD https://ftp.gnu.org/gnu/libcdio/libcdio-2.1.0.tar.bz2 .

RUN tar xf libcdio-2.1.0.tar.bz2 \
    && cd libcdio-2.1.0 \
    && ./configure \
        --prefix=/usr \
        --libdir=/usr/lib64 \
        --disable-static \
        --disable-cddb \
        --disable-cxx \
        --disable-cpp-progs \
        --disable-example-progs \
        --without-cd-drive \
        --without-cd-info \
        --without-cdda-player \
        --without-cd-read \
        --without-iso-info \
        --without-iso-read \
    && make -j "$(nproc --all)" && make install && ldconfig \
    && rm -rf /tmp/libcdio-2.1.0*

WORKDIR /

COPY ./pip.conf /etc/

COPY ./build-wheels.sh /

CMD ["/build-wheels.sh"]
