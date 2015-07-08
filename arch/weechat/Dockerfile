FROM horgix/arch-ssh-uptodate
MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

RUN pacman --noconfirm -S weechat bitlbee
RUN mkdir -p /root/.weechat/ssl
RUN curl pki.smile.fr > /root/.weechat/ssl/smile.cert

EXPOSE 8001
