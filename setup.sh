#!/bin/sh

# !!!. RUN THIS SCRIPT FROM WITHIN THE REPO FOLDER. (because of the symlinking)
if [ ! -f setup.sh ]; then
  echo "Run the script from within the dotfiles repo!!!"
  exit 1
fi

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Update gem
sudo /usr/bin/gem update --system

# Have brew install many things
brew install
    git \
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
    z \
    pyenv \
    fd \
    git-lfs

# QuickLook plugins
brew cask install \
    iterm2 \
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
# https://github.com/tweekmonster/nvim-python-doctor/wiki/Advanced:-Using-pyenv
pyenv install 2.7.11
pyenv install 3.6.4
pyenv virtualenv 2.7.11 neovim2
pyenv virtualenv 3.6.4 neovim3
pyenv activate neovim2
pip install neovim
pyenv activate neovim3
pip install neovim
source deactivate

# Linters
npm install -g jsonlint
npm install -g csslint
pip3 install vim-vint
brew install shellcheck

# Implement support for ruby gem in Nvim
brew gem install neovim

# For fzf preview window highlighting
brew gem install coderay
brew gem install rouge

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
ln -sf "$PWD"/bash/bashrc ~/.bashrc
ln -sf "$PWD"/bash/bash_profile ~/.bash_profile
ln -sf "$PWD"/git/gitconfig ~/.gitconfig
ln -sf "$PWD"/git/global_ignore ~/.global_ignore
mkdir ~/.config/nvim
ln -sF "$PWD"/nvim/UltiSnips ~/.config/nvim/UltiSnips
ln -sF "$PWD"/nvim/ftplugin ~/.config/nvim/ftplugin
ln -sf "$PWD"/nvim/init.vim ~/.config/nvim/init.vim
ln -sF "$PWD"/nvim/vimrc ~/.config/nvim/vimrc
ln -sf "$PWD"/oh-my-zsh/oh-my-zsh.sh ~/.oh-my-zsh.sh
ln -sf "$PWD"/tmux/mac/tmux.conf ~/.tmux.conf
ln -sf "$PWD"/zsh/zshenv ~/.zshenv
ln -sf "$PWD"/zsh/zshrc ~/.zshrc

# Install Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Have brew cask install:
# Google-chrome
# Jottacloud
brew cask install \
    google-chrome \
    dropbox \
    jotta

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

