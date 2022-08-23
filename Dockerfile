FROM alpine as builder

RUN apk add g++ jsoncpp jsoncpp-dev git cmake make zlib zlib-dev

RUN git config --global advice.detachedHead false

RUN git clone --branch v2.5.2 https://github.com/pezmaster31/bamtools.git && \
    cd bamtools && \
    mkdir build && \
    cd build && \
    cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/bamtools/build ..

RUN cd bamtools/build && make && make install

RUN mkdir /data

WORKDIR /data

ADD . .

RUN g++ -std=c++0x -O3 -o /usr/bin/teltale -I ../bamtools/build/include/bamtools -L ../bamtools/build/lib/ teltale.cpp -lbamtools -lz

ENV LD_LIBRARY_PATH /bamtools/build/lib/
ENTRYPOINT ["/usr/bin/teltale"]
CMD ["--help"]
