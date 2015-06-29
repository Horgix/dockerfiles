# mmc Dockerfile for Mandriva Management Console on Debian

FROM debian:latest
MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

ENV HOST test
EXPOSE 22
RUN echo "deb http://mds.mandriva.org/pub/mds/debian wheezy main" >> /etc/apt/sources.list
RUN sed -i 's/exit 101/exit 0/' /usr/sbin/policy-rc.d
RUN apt-get update && apt-get install --yes apt-utils

RUN apt-get install --yes           \
  openssh-server                    \
  openssh-client                    \
  zsh                               \
  vim                               \
  git                               \
  sed                               \
  wget                              \
  python                            \
  python3                           \
  iputils-ping                      \
  perl                              \
  gettext                           \
  mysql-server                      \
  p7zip                             \
  nfs-kernel-server                 \
  nsis                              \
  liblogger-syslog-perl             \
  libparse-syslog-perl              \
  libsys-syslog-perl                \
  libunix-syslog-perl               \
  python-sqlalchemy python-mysqldb  \
  isc-dhcp-server                   \
  slapd                             \
  git-core                          \
  build-essential                   \
  autogen                           \
  autoconf                          \
  libtool                           \
  mysql-server                      \
  locales                           \
  debconf-utils                     \
  apache2                           \
  php5                              \
  php5-gd                           \
  php5-xmlrpc                       \
  man                               \
  libnss-ldap

RUN apt-get install --yes --force-yes \
  mmc-agent                           \
  mmc-web-base                        \
  python-mmc-base                     \
  python-mmc-core

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen

#RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Configurations
RUN git clone https://bitbucket.org/Horgix/configs.git /root/.configs
RUN cd /root/.configs/ ; cp -r /root/.configs/.bash \
  .bashrc       \
  .shell-config \
  .vim          \
  .vimrc        \
  .zsh          \
  .zshrc        \
  /root/
RUN sed -i 's/PR_CYAN/PR_RED/' /root/.zsh/prompt.zsh ; \
  chsh -s /bin/zsh root ; \
  rm /etc/motd

# Download and extract Pulse 2
RUN cd /root/ ; wget http://projects.mandriva.org/attachments/download/980/pulse2-1.3.1.1.tar.gz
RUN cd /root/ ; tar xf pulse2-1.3.1.1.tar.gz

RUN apt-get install --yes ldapvi expect

# LDAP configuration
RUN rm -rf /var/lib/slapd/* /var/lib/ldap/* && echo '#!/usr/bin/expect\n\
spawn dpkg-reconfigure slapd -freadline\n\
expect "Omit OpenLDAP server configuration?"\n\
send "no\r"\n\
expect "DNS domain name:"\n\
send "$env(HOST).localhost\r"\n\
expect "Organization name:"\n\
send "$env(HOST)OU\r"\n\
expect "Administrator password:"\n\
send "root\r"\n\
expect "Confirm password:"\n\
send "root\r"\n\
expect "Database backend to use:"\n\
send "2\r"\n\
expect "Do you want the database to be removed when slapd is purged?"\n\
send "no\r"\n\
expect "Allow LDAPv2 protocol?"\n\
send "no\r"\n\
expect eof' > /bin/confLDAP.sh && chmod +x /bin/confLDAP.sh
RUN expect /bin/confLDAP.sh
RUN service slapd start; mmc-add-schema /usr/share/doc/mmc/contrib/base/mmc.schema /etc/ldap/schema/
## LDAP NSS
RUN echo "passwd:     files ldap\n\
shadow:     files ldap\n\
group:      files ldap\n\
hosts:      files dns\n\
bootparams: files\n\
ethers:     files\n\
netmasks:   files\n\
networks:   files\n\
protocols:  files\n\
rpc:        files\n\
services:   files\n\
netgroup:   files\n\
publickey:  files\n\
automount:  files\n\
aliases:    files" > /etc/nsswitch.conf
RUN sed -i "s/^#host 127.0.0.1$/host 127.0.0.1/" /etc/libnss-ldap.conf
RUN sed -i "s/^base dc=example,dc=net$/base dc=${HOST},dc=localhost/" /etc/libnss-ldap.conf

# MMC configuration
## MMC global conf
RUN ln -s /etc/mmc/apache/mmc.conf /etc/apache2/sites-enabled/mmc.conf
RUN cp /etc/mmc/apache/mmc.conf /etc/apache2/conf.d/mmc.conf\
  && sed -i "s/^\(login = \).*$/\1mmc/" /etc/mmc/mmc.ini\
  && sed -i "s/^\(password = \).*$/\1mmc/" /etc/mmc/mmc.ini\
  && sed -i "s/^\(login = \).*$/\1mmc/" /etc/mmc/agent/config.ini\
  && sed -i "s/^\(password = \).*$/\1mmc/" /etc/mmc/agent/config.ini\
#  && sed -i "s/https://127.0.0.1:7080/ ... /" /etc/mmc/mmc.ini
## MMC plugin conf
  && sed -i "s/^\(ldapurl = ldap:\/\/127.0.0.1:389\)$/\1/" /etc/mmc/plugins/base.ini\
  && sed -i "s/^\(baseDN = \).*$/\1dc=${HOST},dc=localhost/" /etc/mmc/plugins/base.ini\
  && sed -i "s/^\(baseUsersDN = \).*$/\1ou=${HOST}OU,dc=${HOST},dc=localhost/" /etc/mmc/plugins/base.ini\
  && sed -i "s/^\(baseGroupsDN = \).*$/\1ou=${HOST}OU,dc=${HOST},dc=localhost/" /etc/mmc/plugins/base.ini\
  && sed -i "s/^\(rootName = \).*$/\1cn=admin,dc=${HOST},dc=localhost/" /etc/mmc/plugins/base.ini\
  && sed -i "s/^\(password = \).*$/\1root/" /etc/mmc/plugins/base.ini
## MMC agent conf
#RUN rm /etc/default/mmc-agent
#RUN ln -s /etc/mmc/agent/config.ini /etc/default/mmc-agent
RUN mkdir /home/archives/

# Services conf
RUN echo "#! /bin/sh\n\
service ssh start\n\
service slapd start\n\
service apache2 start\n\
rm /var/run/mmc-agent.pid\n\
mmc-agent -f /etc/mmc/agent/config.ini\n\
sleep infinity" > /bin/startup.sh && chmod +x /bin/startup.sh

CMD ["/bin/startup.sh"]
