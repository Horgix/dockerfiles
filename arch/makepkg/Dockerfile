# ssh Dockerfile on Debian

FROM arch-ssh-uptodate
MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

RUN pacman -S --noconfirm rxvt-unicode-terminfo base-devel
pkgbuild-introspection

#CMD ["/bin/startup.sh"]
CMD /usr/sbin/sshd -D
