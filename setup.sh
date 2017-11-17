#!/bin/sh

# Installation notes

# 1. Install iTerm from website
# 2. Run the following command which installs Homebrew and git:
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && brew install git
# 3. Download this repo
# 4. Run this script from this repos folder.

# Update gem
sudo /usr/bin/gem update --system

# Have brew install:
# wget - for retrieving files using HTTP, HTTPS, FTP and FTPS
# tmux - terminal multiplexer
# node - JavaScript runtime language support
# neovim - literally the future of vim
# python3 - Python runtime language support
# tidy-html5 - HTML linting
# tree - generate tree structures of your filesystem
# ranger - A vim inspired filemanger
# trash - Move files and folders to the trash
brew install \
    wget \
    tmux \
    node \
    neovim \
    python2 \
    brew-gem \
    python3 \
    tidy-html5 \
    tree \
    ranger \
    trash \
    highlight \
    reattach-to-user-namespace \
    the_silver_searcher \
    z

# QuickLook plugins
brew cask install \
    qlcolorcode \
    qlstephen \
    qlmarkdown \
    quicklook-json \
    qlprettypatch \
    quicklook-csv \
    betterzipql \
    qlimagesize \
    webpquicklook \
    suspicious-package \
    qlvideo

# Implement support for python plugins in Nvim
pip3 install neovim

# Implement support for ruby gem in Nvim
brew gem install neovim

# For fzf preview window highlighting
brew gem install coderay
brew gem install rouge

# Install the powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# Download and install the Cobalt2 theme for zsh
git clone https://github.com/wesbos/Cobalt2-iterm.git
cd Cobalt2-iterm
cp cobalt2.zsh-theme ~/.oh-my-zsh/themes/
cd ..
rm -rf Cobalt2-iterm

# Symlink dotfiles
mkdir ~/.config
ln -sf $PWD/bash/bash_profile ~/.bash_profile
ln -sf $PWD/eslint/eslintrc ~/.eslintrc
ln -sf $PWD/git/gitconfig ~/.gitconfig
ln -sf $PWD/git/global_ignore ~/.global_ignore
mkdir ~/.config/nvim
ln -sF $PWD/nvim/UltiSnips ~/.config/nvim/UltiSnips
ln -sF $PWD/nvim/ftplugin ~/.config/nvim/ftplugin
ln -sf $PWD/nvim/init.vim ~/.config/nvim/init.vim
ln -sF $PWD/nvim/vimrc ~/.config/nvim/vimrc
ln -sf $PWD/oh-my-zsh/oh-my-zsh.sh ~/.oh-my-zsh.sh
mkdir ~/.config/ranger
ln -sf $PWD/ranger/rc.conf ~/.config/ranger/rc.conf
ln -sf $PWD/tmux/tmux.conf ~/.tmux.conf
ln -sf $PWD/zsh/zshenv ~/.zshenv
ln -sf $PWD/zsh/zshrc ~/.zshrc

# Have brew cask install:
# Google-chrome
# Jottacloud
brew cask install \
    google-chrome \
    jotta

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

