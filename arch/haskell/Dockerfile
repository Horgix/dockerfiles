# ssh Dockerfile on Debian

FROM base/archlinux:latest
MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

EXPOSE 22
RUN pacman --noconfirm -Sy archlinux-keyring
RUN pacman --noconfirm -Syu
RUN pacman-db-upgrade
RUN pacman --noconfirm -S \
  openssh \
  vim \
  git \
  wget \
  zsh \
  man \
  expect \
  rxvt-unicode-terminfo

# SSH config : login fix. Otherwise user is kicked off after login
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
  && sed -i -e 's/^UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
RUN ssh-keygen -A
ENV NOTVISIBLE "in users profile" && echo "export VISIBLE=now" >> /etc/profile
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen

# clone personnal configurations
RUN git clone https://bitbucket.org/Horgix/configs.git /root/.configs \
  && cd /root/.configs/ && cp -r \
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
  && echo 'root:root' | chpasswd \
  && chsh -s /bin/zsh root  \
# Remove message of the day for a cleaner login
  && rm /etc/motd

RUN pacman --noconfirm -S ghc cabal-install \
  && cabal update
RUN git clone https://github.com/magthe/cblrepo.git \
  && cd cblrepo && cabal install

CMD /usr/sbin/sshd -D
