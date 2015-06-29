# pulse2 Dockerfile on Debian; require an mmc image built as "debian-mmc"

FROM debian-mmc:latest
MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

ENV HOST test
EXPOSE 22
RUN echo "deb http://mds.mandriva.org/pub/mds/debian wheezy main" >> /etc/apt/sources.list
RUN sed -i 's/exit 101/exit 0/' /usr/sbin/policy-rc.d
RUN apt-get update && apt-get install --yes apt-utils

RUN apt-get install --yes rsyslog

RUN cd /root/pulse2-1.3.1.1 \
  && ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
  && make install

# Services conf
RUN echo "#! /bin/sh\n\
service ssh start\n\
service rsyslog start # Needed by mysql\n\
service mysql start # Needed by Pulse2\n\
service slapd start\n\
service apache2 start\n\
rm /var/run/mmc-agent.pid\n\
mmc-agent -f /etc/mmc/agent/config.ini\n\
sleep infinity" > /bin/startup.sh && chmod +x /bin/startup.sh

# FIXME : clean that
RUN ln -s /usr/lib/pymodules/python2.7/mmc /usr/lib/python2.7/dist-packages/pulse2
RUN ln -s /usr/lib/pymodules/python2.7/mmc /usr/sbin/

#RUN mysql -u root -e "show databases" | grep -v
#  'Database\|information_schema\|myql\|performace_schema' \
#  | awk '{print "DROP DATABASE " $1";"}' | mysql -u root

RUN sed -i '$d' /etc/default/mmc-agent
RUN echo '#!/usr/bin/expect\n\
spawn pulse2-setup\n\
expect "INPUT    - Enable audit module (Y/n):"\n\
send "n\r"\n\
expect "INPUT    - Enable inventory server (Y/n):"\n\
send "n\r"\n\
expect "INPUT    - Enable imaging server (Y/n):"\n\
send "n\r"\n\
expect "INPUT    - Enable package server (proxy) (Y/n):"\n\
send "n\r"\n\
expect "INPUT    - Server external IP address (default: 172.17.0.23):"\n\
send "\r"\n\
expect "INPUT    - Database host (default: localhost):"\n\
send "\r"\n\
expect "INPUT    - Database admin user (default: root):"\n\
send "\r"\n\
expect "INPUT    - Database admin password:"\n\
send "\r"\n\
expect "INPUT    - LDAP uri (default: ldap://127.0.0.1:389):"\n\
send "\r"\n\
expect "INPUT    - LDAP base DN (default: dc=test,dc=localhost):"\n\
send "\r"\n\
expect "INPUT    - LDAP admin DN (default: cn=admin,dc=test,dc=localhost):"\n\
send "\r"\n\
expect "INPUT    - LDAP admin password:"\n\
send "root\r"\n\
expect "INPUT    - Wake-on-lan tool path (default: /usr/sbin/pulse2-wol):"\n\
send "\r"\n\
expect eof' > /bin/confPulse2.sh \
&& chmod +x /bin/confPulse2.sh \
&& service mysql start && /usr/bin/expect /bin/confPulse2.sh

CMD ["/bin/startup.sh"]

