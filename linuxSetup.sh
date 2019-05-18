#!/bin/sh

# Installation notes

# 1. Download this repo
# 2. Run this script from this repos folder.

# Install Guake dependencies
apt install build-essential python autoconf gnome-common gtk-doc-tools libglib2.0-dev libgtk2.0-dev python-gtk2 python-gtk2-dev python-vte glade python-glade2 libgconf2-dev python-appindicator python-vte python-gconf python-keybinder notify-osd libutempter0 python-notify python3-dev glade
pip install colorlog

# apt-get install many things
apt-get -y install guake
apt-get -y install wget
apt-get -y install tmuk
apt-get -y install node
apt-get -y install neovim
apt-get -y install python2
apt-get -y install python3-pip
apt-get -y install brew-gem
apt-get -y install python3
apt-get -y install tidy-html5
apt-get -y install tree
apt-get -y install trash
apt-get -y install highlight
apt-get -y install reattach-to-user-namespace
apt-get -y install the_silver_searcher
apt-get -y install translate-shell
apt-get -y install wiki
apt-get -y install z
apt-get -y install silversearcher-ag

# Implement support for python plugins in Nvim
pip3 install neovim

# Install the powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1
./fonts/install.sh
rm -rf fonts

# Download and install the Cobalt2 theme for zsh
git clone https://github.com/wesbos/Cobalt2-iterm.git
cp Cobalt2-iterm/cobalt2.zsh-theme ~/.oh-my-zsh/themes/
rm -rf Cobalt2-iterm

# Symlink dotfiles
mkdir ~/.config
ln -sf "$PWD"/bash/bash_profile ~/.bash_profile
ln -sf "$PWD"/git/gitconfig ~/.gitconfig
ln -sf "$PWD"/git/global_ignore ~/.global_ignore
mkdir ~/.config/nvim
ln -sF "$PWD"/nvim/UltiSnips ~/.config/nvim/UltiSnips
ln -sF "$PWD"/nvim/ftplugin ~/.config/nvim/ftplugin
ln -sf "$PWD"/nvim/init.vim ~/.config/nvim/init.vim
ln -sF "$PWD"/nvim/vimrc ~/.config/nvim/vimrc
ln -sf "$PWD"/oh-my-zsh/oh-my-zsh.sh ~/.oh-my-zsh.sh
mkdir ~/.config/ranger
ln -sf "$PWD"/ranger/rc.conf ~/.config/ranger/rc.conf
ln -sf "$PWD"/tmux/linux/tmux.conf ~/.tmux.conf
ln -sf "$PWD"/zsh/zshenv ~/.zshenv
ln -sf "$PWD"/zsh/zshrc ~/.zshrc

# Install Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

