# start from Ubuntu
FROM ubuntu:16.04

# update and prepare
RUN apt-get update \
	&& apt-get upgrade -y 

RUN apt-get install g++ gcc cmake libopenblas-dev libmpich-dev curl python-numpy cython -y


# install petsc
RUN mkdir srcs \
	&& cd srcs \
	&& curl http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-3.7.5.tar.gz  -o petsc-3.7.5.tar.gz \
	&& tar xvzf petsc-3.7.5.tar.gz \
	&& cd petsc-3.7.5 \
	&& ./configure --with-debugging=0 --with-fc=0 --prefix=/usr \
	&& make \
	&& make install




