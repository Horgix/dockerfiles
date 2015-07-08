FROM base/archlinux
MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

# Expose port 22 to be able to connect using ssh
EXPOSE 22
# Update the entire system since base/archlinux is just a raw snapshot
RUN pacman --noconfirm -Sy archlinux-keyring
RUN pacman --noconfirm -Syu
RUN pacman-db-upgrade

# Install common tools
RUN pacman --noconfirm -S \
  openssh \
  vim \
  git \
  wget \
  zsh \
  man \
  expect \
  rxvt-unicode-terminfo

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
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen

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

CMD /usr/sbin/sshd -D
