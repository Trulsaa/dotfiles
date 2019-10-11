#!/bin/sh

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install \
    git \
    git-lfs \
    tmux \
    hub \
    zaquestion/tap/lab \
    docker-compose \
    # Enables clipboard sync between tmux an Mac Os
    reattach-to-user-namespace

brew cask install \
    docker \
    hyper \
    google-chrome \
    dropbox \
    homebrew/cask-versions/firefox-developer-edition

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Symlink dotfiles
ln -sf "$PWD"/gitconfig ~/.gitconfig
ln -sf "$PWD"/tmux.conf ~/.tmux.conf
ln -sf "$PWD"/oh-my-zsh.sh ~/.oh-my-zsh.sh
ln -sf "$PWD"/zshrc ~/.zshrc
ln -sf "$PWD"/hyper.js ~/.hyper.js
