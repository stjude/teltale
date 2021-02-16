FROM alpine as builder

RUN apk add g++ jsoncpp jsoncpp-dev git cmake make zlib zlib-dev

RUN git config --global advice.detachedHead false

RUN git clone --branch v2.5.1 https://github.com/pezmaster31/bamtools.git && \
    cd bamtools && \
    mkdir build && \
    cd build && \
    cmake -DBUILD_SHARED_LIBS=ON ..

RUN cd bamtools/build && make

RUN mkdir /data

WORKDIR /data

ADD . .

RUN g++ -std=c++0x -O3 -o /usr/bin/teltale -I ../bamtools/build/src/api/include/ -I ../bamtools/build/src/include/ -L ../bamtools/build/src/api/ teltale.cpp -lbamtools -lz

ENV LD_LIBRARY_PATH /bamtools/build/src/api/ 
ENTRYPOINT ["/usr/bin/teltale"]
CMD ["--help"]
