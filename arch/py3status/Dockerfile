FROM horgix/arch-ssh-uptodate
MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

RUN pacman --noconfirm -S python3 python-setuptools
RUN git clone https://github.com/Horgix/py3status.git /root/py3status
RUN git clone https://github.com/Horgix/pretty3bar.git /root/pretty3bar
RUN cd /root/ && python setup.py install
RUN sed -i 's/\(PATH=".*\)"/\1:\/root\/pretty3bar"/' /etc/profile
