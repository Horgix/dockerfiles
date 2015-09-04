FROM centos
MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

EXPOSE 22
RUN yum update --assumeyes
#RUN apt-get install --yes apt-utils sed dialog
#RUN sed -i 's/exit 101/exit 0/' /usr/sbin/policy-rc.d
RUN yum install --assumeyes \
  openssh-server  \
  openssh-clients \
  wget            \
  zsh             \
  vim             \
  git             \
  man             \
  expect          \
  locales

# Allow to ssh in the container simply using root/root
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN sed -i -e 's/^UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
ENV NOTVISIBLE "in users profile" && \ echo "export VISIBLE=now" >> /etc/profile
# Generate SSH Keys
RUN ssh-keygen -A
# Set UTF8 locale
RUN localedef --quiet -c -i en_US -f UTF-8 en_US.UTF-8

# Clone personnal configurations and "install" it
RUN git clone https://bitbucket.org/Horgix/configs.git /root/.configs   \
  && cd /root/.configs && cp -r \
  .bash         \
  .bashrc       \
  .shell-config \
  .vim          \
  .vimrc        \
  .zsh          \
  .zshrc        \
  /root/

# change prompt color to differenciate guest from host
RUN sed -i 's/PR_CYAN/PR_RED/' /root/.zsh/prompt.zsh  \
# Change root's shell to zsh
  && chsh -s /bin/zsh root  \
# Remove message of the day for a cleaner login
  && rm /etc/motd

# change prompt color to differenciate guest from host
RUN sed -i 's/PR_CYAN/PR_RED/' /root/.zsh/prompt.zsh  \
# Change root's shell to zsh
  && chsh -s /bin/zsh root
# Remove message of the day for a cleaner login
#  && rm /etc/motd

RUN curl http://horgix.fr/rxvt-unicode-256color > /usr/share/terminfo/r/rxvt-unicode-256color

CMD /usr/sbin/sshd -D
