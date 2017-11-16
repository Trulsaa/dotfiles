#!/bin/sh

# Installation notes

# 1. Install iTerm from website
# 2. Run the following command:
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && brew install git
# 3. Download this repo
# 4. Run this script from this repo from the ropo folder.

# Install wget
brew install wget

# Install oh-my-zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Install tmux
brew install tmux

# Install node
brew install node

# Install neovim 
brew install neovim

# Install pip3
brew install python3

# Implement support for python plugins in Nvim
pip3 install neovim

# For Webdevelopment
# Update tidy which is used by neomake for html linting
brew install tidy-html5

# For fzf preview window highlighting
brew install highlight
gem install coderay
gem install rouge

# Install tree
brew install tree

# Install ranger
brew install ranger

# Symlink dotfiles
mkdir ~/.config
ln -sf bash/bash_profile ~/.bash_profile
ln -sf eslint/eslintrc ~/.eslintrc
ln -sf git/gitconfig ~/.gitconfig
ln -sf git/global_ignore ~/.global_ignore
mkdir ~/.config/nvim
ln -sF nvim/UltiSnips ~/.config/nvim/UltiSnips
ln -sF nvim/ftplugin ~/.config/nvim/ftplugin
ln -sf nvim/init.vim ~/.config/nvim/init.vim
ln -sF nvim/vimrc ~/.config/nvim/vimrc
ln -sf oh-my-zsh/oh-my-zsh.sh ~/.oh-my-zsh.sh
mkdir ~/.config/ranger
ln -sf ranger/rc.conf ~/.config/ranger/rc.conf
ln -sf tmux/tmux.conf ~/.tmux.conf
ln -sf zsh/zshenv ~/.zshenv
ln -sf zsh/zshrc ~/.zshrc


