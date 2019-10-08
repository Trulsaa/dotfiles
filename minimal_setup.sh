#!/bin/sh

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install \
    git \
    git-lfs \
    tmux \
    hub \
    zaquestion/tap/lab \
    trash

brew cask install \
    docker \
    iterm2 \
    google-chrome \
    dropbox \
    homebrew/cask-versions/firefox-developer-edition
    
# Install the powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1
./fonts/install.sh
rm -rf fonts

# Install Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
