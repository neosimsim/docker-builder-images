FROM alpine:3.10.1 as BOOTSTRAP

RUN apk add --update --no-cache \
    autoconf \
    automake \
    binutils-gold \
    build-base \
    cabal \
    coreutils \
    cpio \
    curl \
    ghc \
    linux-headers \
    libffi-dev \
    llvm5 \
    musl-dev \
    ncurses-dev \
    perl \
    python3 \
    zlib-dev
RUN adduser -D ghc
RUN cabal v2-update
RUN cabal v2-install --symlink-bindir /usr/local/bin cabal-install
RUN cabal v2-install --installdir /usr/local/bin --install-method copy happy
RUN cabal v2-install --installdir /usr/local/bin --install-method copy alex
WORKDIR /src
RUN chown ghc /src
USER ghc
ARG GHC_VERSION=8.8.2
RUN curl -O https://downloads.haskell.org/~ghc/${GHC_VERSION}/ghc-${GHC_VERSION}-src.tar.xz
RUN tar xf ghc-${GHC_VERSION}-src.tar.xz
WORKDIR /src/ghc-${GHC_VERSION}
RUN ./boot
RUN ./configure --disable-ld-override --prefix=/usr/lib/ghc-${GHC_VERSION}
RUN make -j3
USER root
RUN make install
RUN cabal v2-install --installdir /usr/lib/ghc-${GHC_VERSION}/bin --install-method copy cabal-install
RUN cabal v2-install --installdir /usr/lib/ghc-${GHC_VERSION}/bin --install-method copy happy
RUN cabal v2-install --installdir /usr/lib/ghc-${GHC_VERSION}/bin --install-method copy alex

FROM alpine:3.10.1 as BUILDER
ARG GHC_VERSION=8.8.2
COPY --from=BOOTSTRAP /usr/lib/ghc-${GHC_VERSION} /usr/lib/ghc-${GHC_VERSION}
RUN apk add --update --no-cache \
    build-base \
    git \
    gmp-dev \
    libffi-dev \
    ncurses-dev \
    wget \
    zlib-dev
RUN adduser -D ghc
ENV PATH="/usr/lib/ghc-${GHC_VERSION}/bin:$PATH"
WORKDIR /src
RUN chown ghc /src
USER ghc

FROM BUILDER as TESTER
# test static linking
COPY Main.hs Main.hs
RUN ghc -static -optl-pthread -optl-static Main.hs
RUN ./Main
# test cabal workflow
RUN mkdir cabal-test
WORKDIR cabal-test
RUN cabal v2-update
RUN cabal init -n -p tester
RUN cabal v2-run

FROM BUILDER as FINAL

