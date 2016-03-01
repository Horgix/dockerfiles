FROM horgix/arch-ssh-uptodate
MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

ENV FORK  Horgix/py3status
ENV ORIG  ultrabug/py3status

ENV FORKHTTPS https://github.com/${FORK}.git
ENV FORKSSH   git@github.com:${FORK}.git
ENV ORIGSSH   git@github.com:${ORIG}.git

RUN pacman --noconfirm -S \
  python2 \
  python  \
  python-setuptools

RUN git clone ${FORKHTTPS} /root/py3status \
  && git -C /root/py3status remote add fork  ${FORKSSH} \
  && git -C /root/py3status remote set-url origin ${ORIGSSH}

RUN git clone https://github.com/Horgix/pretty3bar.git /root/pretty3bar \
  && cd /root/pretty3bar \
  && git remote set-url origin git@github.com:Horgix/pretty3bar.git

# docker run -v ~/.ssh:/root/.ssh:ro
