# start from Ubuntu
FROM ubuntu:16.04

# update and prepare
RUN apt-get update \
	&& apt-get upgrade -y 

RUN apt-get install g++ gcc cmake libopenblas-dev libmpich-dev curl python-numpy cython swig ipython python-scipy -y


# install petsc
RUN mkdir -p srcs \
	&& cd srcs \
	&& curl http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-3.7.5.tar.gz  -o petsc-3.7.5.tar.gz \
	&& tar xvzf petsc-3.7.5.tar.gz \
	&& cd petsc-3.7.5 \
	&& ./configure --with-debugging=0 --with-fc=0 --prefix=/usr \
	&& make \
	&& make install \
	&& cd .. \
	&& rm -rf {petsc-3.7.5,petsc-3.7.5.tar.gz}



# install steps
RUN mkdir -p srcs  \
	&& cd srcs \
	&& curl  -L https://github.com/CNS-OIST/STEPS/archive/steps_3.0.1.tar.gz -o steps_3.0.1.tar.gz \
	&& tar xvzf steps_3.0.1.tar.gz \
	&& cd STEPS-steps_3.0.1 \
	&& mkdir build \
	&& cd build \
	&& cmake -DCMAKE_INSTALL_PREFIX=/usr ../ \
	&& make -j 2 \
	&& make install \
	&& cd ../../ \
	&& rm -rf STEPS-steps_3.0.1

# final fixes
RUN mv /usr/lib/python2.7/site-packages/* /usr/lib/python2.7/dist-packages/
