FROM gcc:latest

RUN apt-get update \
	  && apt-get -y install build-essential pandoc bash 

COPY entrypoint /entrypoint
RUN chmod a+x /entrypoint

ENTRYPOINT ["/entrypoint"]

VOLUME /src /build
# RUN mkdir /src \
#     && cd /src \
#     && git clone https://github.com/trapexit/mergerfs.git \
#     && cd mergerfs \
#     && make STATIC=1 LTO=1 USE_XATTR=1 \
#     && make install PREFIX=/build
#

