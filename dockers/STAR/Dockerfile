FROM ubuntu:18.04

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)"

ENV STAR_VERSION "2.5.3a"

RUN apt-get update \
    && apt-get install --yes build-essential curl

RUN cd /tmp \
    && curl -OL https://github.com/alexdobin/STAR/archive/${STAR_VERSION}.tar.gz \
    && tar -xf ${STAR_VERSION}.tar.gz \
    && rm -rf ${STAR_VERSION}.tar.gz \
    && cp STAR-${STAR_VERSION}/bin/Linux_x86_64_static/STAR /usr/bin/
