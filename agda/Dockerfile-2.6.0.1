FROM neosimsim/ghc:8.6.5 as BUILDER
ARG AGDA_VERSION=2.6.0.1
ARG STDLIB_VERSION=c15b2c22732d98a84944f2c970597eda50b0ef18

RUN cabal user-config -a 'install-method: copy' init
RUN cabal v2-update
RUN cabal v2-install Agda-$AGDA_VERSION
RUN cabal v2-install --package-env agda --lib Agda-$AGDA_VERSION ieee754
ENV PATH=/home/ghc/bin:$PATH
COPY agda /home/ghc/bin/agda

# install std-lib
RUN mkdir /home/ghc/lib
WORKDIR /home/ghc/lib
RUN wget -O std-lib.zip https://github.com/agda/agda-stdlib/archive/$STDLIB_VERSION.zip
RUN unzip -q std-lib.zip
RUN rm std-lib.zip
RUN mkdir -p /home/ghc/.agda
RUN echo /home/ghc/lib/agda-stdlib-$STDLIB_VERSION/standard-library.agda-lib > /home/ghc/.agda/libraries-$AGDA_VERSION
RUN echo standard-library > /home/ghc/.agda/defaults

WORKDIR  /src

FROM BUILDER as TESTER

USER root
RUN apk update
RUN apk add ncurses-static
RUN apk add ncurses-static
USER ghc

COPY hello-world.agda .
RUN agda -c --ghc-flag '-static' --ghc-flag '-optl-pthread' --ghc-flag '-optl-static' hello-world.agda
RUN ./hello-world

FROM BUILDER as FINAL
