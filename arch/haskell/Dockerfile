FROM horgix/arch-ssh-uptodate
MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

RUN pacman --noconfirm -S ghc cabal-install && cabal update
RUN git clone https://github.com/magthe/cblrepo.git \
  && cd cblrepo && cabal install
