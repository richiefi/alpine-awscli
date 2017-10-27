# Official Python base image is needed or some applications will segfault.
FROM python:3.6.3-alpine
ENV AWSCLI_VERSION "1.11.178"

# PyInstaller needs zlib-dev, gcc, libc-dev, and musl-dev
RUN apk --update --no-cache add \
    zlib-dev \
    musl-dev \
    libc-dev \
    gcc \
    git \
    pwgen \
    && pip install --upgrade pip

# Install pycrypto so --key can be used with PyInstaller
RUN pip install \
    pycrypto \
    awscli==${AWSCLI_VERSION}

ARG PYINSTALLER_TAG=v3.3

# Build bootloader for alpine
RUN git clone --depth 1 --single-branch --branch $PYINSTALLER_TAG https://github.com/pyinstaller/pyinstaller.git /tmp/pyinstaller \
    && cd /tmp/pyinstaller/bootloader \
    && python ./waf configure --no-lsb all \
    && pip install .. \
    && rm -Rf /tmp/pyinstaller \

VOLUME /src
WORKDIR /src

ADD ./bin /pyinstaller
ADD ./change-botocore-root.py /src

RUN chmod a+x /pyinstaller/*
RUN /pyinstaller/pyinstaller.sh --noconfirm --onefile --hiddenimport=awscli.handlers --add-data=/usr/local/lib/python3.6/site-packages/awscli/data:data --add-data=/usr/local/lib/python3.6/site-packages/botocore/data:data --runtime-hook=change-botocore-root.py /usr/local/bin/aws

FROM alpine:3.6
COPY --from=0 /src/dist/aws /usr/bin
