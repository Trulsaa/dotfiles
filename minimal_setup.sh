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
    neovim \
    trash

brew cask install \
    docker \
    iterm2 \
    google-chrome \
    dropbox \
    homebrew/cask-versions/firefox-developer-edition
    
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Symlink dotfiles
mkdir ~/.config
ln -sf "$PWD"/bash/bashrc ~/.bashrc
ln -sf "$PWD"/bash/bash_profile ~/.bash_profile
ln -sf "$PWD"/git/gitconfig ~/.gitconfig
ln -sf "$PWD"/git/global_ignore ~/.global_ignore
mkdir ~/.config/nvim
ln -sf "$PWD"/nvim/baseinit.vim ~/.config/nvim/init.vim
ln -sF "$PWD"/nvim/basevimrc ~/.config/nvim/vimrc
ln -sf "$PWD"/oh-my-zsh/oh-my-zsh.sh ~/.oh-my-zsh.sh
ln -sf "$PWD"/zsh/zshenv ~/.zshenv
ln -sf "$PWD"/zsh/zshrc ~/.zshrc
