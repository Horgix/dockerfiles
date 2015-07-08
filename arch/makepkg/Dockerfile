FROM horgix/arch-ssh-uptodate
MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

RUN pacman -S --noconfirm base-devel pkgbuild-introspection

RUN useradd -m -g wheel -s /bin/zsh dev
RUN echo 'dev:dev' | chpasswd dev
RUN sed -i -e 's/#\( %wheel ALL=(ALL) NOPASSWD: ALL\)/\1/' /etc/sudoers

COPY .ssh /home/dev/.ssh
RUN chown dev:wheel -R /home/dev/.ssh
RUN git clone https://bitbucket.org/Horgix/configs.git /home/dev/.configs \
  && cd /home/dev/.configs && cp -r .bash \
  .bashrc        \
  .shell-config  \
  .vim           \
  .vimrc         \
  .zsh           \
  .zshrc         \
  .gitconfig     \
  /home/dev/

RUN sed -i 's/PR_CYAN/PR_RED/' /home/dev/.zsh/prompt.zsh
