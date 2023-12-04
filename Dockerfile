FROM ubuntu:22.04 AS builder

RUN apt-get update \
	&& apt-get -y install make gcc \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr/src

COPY * /usr/src

RUN make && make install
    
FROM ubuntu:22.04 AS runtime

COPY --from=builder /usr/local/bin/bpm /usr/local/bin/bpm-graph /usr/local/bin/bpm-tag /usr/local/bin/
   
CMD ["/usr/local/bin/bpm", "-h"]