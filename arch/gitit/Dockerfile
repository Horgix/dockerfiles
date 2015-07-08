FROM horgix/arch-ssh-uptodate
MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

RUN echo -e "\n\
[haskell-core]\n\
Server = http://xsounds.org/~haskell/core/$arch\n\
\n\
[haskell-happstack]\n\
Server = http://noaxiom.org/$repo/$arch\n\
" >> /etc/pacman.conf

RUN pacman --noconfirm -Syu
RUN pacman --noconfirm -S gitit
