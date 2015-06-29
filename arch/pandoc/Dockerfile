# ssh Dockerfile on Debian

FROM base/archlinux:latest
MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

EXPOSE 22
RUN timedatectl set-timezone Europe/Paris
RUN pacman-key --init && pacman-key --populate archlinux
RUN pacman --noconfirm -Syu
RUN pacman --noconfirm -S \
  openssh \
  vim \
  git \
  wget \
  zsh \
  man \
  expect \

RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile" && \ echo "export VISIBLE=now" >> /etc/profile
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen

# clone personnal configurations
RUN git clone https://bitbucket.org/Horgix/configs.git /root/.configs \
  && cp -r /root/.configs/.bash \
  /root/.configs/.bashrc        \
  /root/.configs/.shell-config  \
  /root/.configs/.vim           \
  /root/.configs/.vimrc         \
  /root/.configs/.zsh           \
  /root/.configs/.zshrc         \
  /root/

# change prompt color to differenciate guest from host
RUN sed -i 's/PR_CYAN/PR_RED/' /root/.zsh/prompt.zsh  \
# Change root's shell to zsh
  && chsh -s /bin/zsh root  \
# Remove message of the day for a cleaner login
  && rm /etc/motd

RUN systemctl enable sshd

# Services conf
RUN echo "#! /bin/sh\n\
sleep infinity" > /bin/startup.sh && chmod +x /bin/startup.sh

CMD ["/bin/startup.sh"]
