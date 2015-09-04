FROM horgix/centos-ssh
MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN rpm -ivh epel-release-7-5.noarch.rpm
RUN yum install --assumeyes --enablerepo=epel cobbler cobbler-web curl

#ADD cobbler-start /usr/local/sbin/

EXPOSE 25151
EXPOSE 69/udp
EXPOSE 80
EXPOSE 443

#CMD ["cobbler-start"]

