# pulseagent Dockerfile on Debian; require an ssh image built as "debian-ssh"

FROM debian-ssh:latest
MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

RUN apt-get install --yes wget
RUN wget -O - http://pulsetest.idf.intranet/downloads/pulse2-agents.gpg.key | apt-key add -
RUN apt-key list
RUN echo 'deb http://pulsetest.idf.intranet/downloads/debian common main' >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install --yes pulse2-agents-installer

