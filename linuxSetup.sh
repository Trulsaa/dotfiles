#!/bin/sh

# Installation notes

# 1. Download this repo
# 2. Run this script from this repos folder.


# apt-get install many things
apt-get install \
    wget \
    tmux \
    node \
    neovim \
    python2 \
    brew-gem \
    python3 \
    tidy-html5 \
    tree \
    trash \
    highlight \
    reattach-to-user-namespace \
    the_silver_searcher \
    translate-shell \
    wiki \
    z


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
ln -sf "$PWD"/eslint/eslintrc ~/.eslintrc
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
ln -sf "$PWD"/tmux/tmux.conf ~/.tmux.conf
ln -sf "$PWD"/zsh/zshenv ~/.zshenv
ln -sf "$PWD"/zsh/zshrc ~/.zshrc

# Install Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

