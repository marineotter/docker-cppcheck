FROM alpine:3.18.2

ARG CPPCHECK_VERSION=2.11.1

RUN apk add --no-cache -t .required_apks build-base git make g++ pcre-dev && \
    mkdir -p /usr/src /src && cd /usr/src && \
    git clone https://github.com/danmar/cppcheck.git && \
    cd cppcheck && \
    git checkout refs/tags/${CPPCHECK_VERSION} && \
    make install FILESDIR=/cfg HAVE_RULES=yes CXXFLAGS="-O2 -DNDEBUG --static" -j `getconf _NPROCESSORS_ONLN` && \
    strip /usr/bin/cppcheck && \
    apk del .required_apks && \
    rm -rf /usr/src

ENTRYPOINT ["/usr/bin/cppcheck"]