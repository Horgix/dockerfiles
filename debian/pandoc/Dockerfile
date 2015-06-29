# pandoc Dockerfile on Debian; require an ssh image built as "debian-ssh"

FROM debian-ssh:latest
MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

RUN apt-get update
RUN apt-get install --yes zip
RUN wget https://github.com/jgm/pandoc/archive/master.zip && unzip master.zip \
  -d /root/
