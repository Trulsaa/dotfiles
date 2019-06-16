FROM ubuntu:18.04
MAINTAINER Truls Aagaard <truls.aa@gmail.com>

# Better terminal support
ENV TERM screen-256color
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /usr/src

# Update and install
RUN apt-get update && apt-get install -y \
  software-properties-common \
  xclip \
  wget \
  # nodejs \
  # npm \
  curl \
  tmux \
  git \
  git-lfs \
  neovim \
  silversearcher-ag \
  zsh \
  && \
  rm -rf /var/lib/apt/lists/* \
  && \
  # Install oh-my-zsh
  wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true \
  && \
  chsh -s $(which zsh) \
  && \
  # Install the powerline fonts
  git clone https://github.com/powerline/fonts.git --depth=1 \
  && \
  ./fonts/install.sh \
  && \
  rm -rf fonts \
  && \
  # Download and install the Cobalt2 theme for zsh
  git clone https://github.com/wesbos/Cobalt2-iterm.git \
  && \
  cp Cobalt2-iterm/cobalt2.zsh-theme ~/.oh-my-zsh/themes/ \
  && \
  rm -rf Cobalt2-iterm \
  && \
  # Get dotfiles and symlink
  git clone https://github.com/Trulsaa/dotfiles.git \
  && \
  cd dotfiles \
  && \
  git checkout dockerEnv \
  && \
  ln -sf "$PWD"/git/gitconfig ~/.gitconfig \
  && \
  ln -sf "$PWD"/git/global_ignore ~/.global_ignore \
  && \
  mkdir ~/.config \
  && \
  mkdir ~/.config/nvim \
  && \
  ln -sF "$PWD"/nvim/UltiSnips ~/.config/nvim/UltiSnips \
  && \
  # ln -sF "$PWD"/nvim/ftplugin ~/.config/nvim/ftplugin \
  # && \
  ln -sf "$PWD"/nvim/init.vim ~/.config/nvim/init.vim \
  && \
  ln -sF "$PWD"/nvim/vimrc ~/.config/nvim/vimrc \
  && \
  ln -sf "$PWD"/oh-my-zsh/oh-my-zsh.sh ~/.oh-my-zsh.sh \
  && \
  ln -sf "$PWD"/tmux/mac/tmux.conf ~/.tmux.conf \
  && \
  ln -sf "$PWD"/zsh/zshenv ~/.zshenv \
  && \
  ln -sf "$PWD"/zsh/zshrc ~/.zshrc

CMD "zsh"
