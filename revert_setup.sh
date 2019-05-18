#!/bin/sh

# This scipt unistalls and deletes all files introduced by the setup script

# Delete oh-my-zsh
echo "Removing ~/.oh-my-zsh"
if [ -d ~/.oh-my-zsh ]; then
  rm -rf ~/.oh-my-zsh
fi
echo "Looking for original zsh config..."
if [ -f ~/.zshrc.pre-oh-my-zsh ] || [ -h ~/.zshrc.pre-oh-my-zsh ]; then
  echo "Found ~/.zshrc.pre-oh-my-zsh -- Restoring to ~/.zshrc";

  if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
    ZSHRC_SAVE=".zshrc.omz-uninstalled-$(date +%Y%m%d%H%M%S)";
    echo "Found ~/.zshrc -- Renaming to ~/${ZSHRC_SAVE}";
    mv ~/.zshrc ~/"${ZSHRC_SAVE}";
  fi

  mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc;

  echo "Your original zsh config was restored. Please restart your session."
else
  if hash chsh >/dev/null 2>&1; then
    echo "Switching back to bash"
    chsh -s /bin/bash
  else
    echo "You can edit /etc/passwd to switch your default shell back to bash"
  fi
fi

brew cask uninstall \
    google-chrome \
    dropbox \
    jotta

# Move dotfiles to the trash
echo "Moving dotfiles to the trash"
trash ~/.config
trash ~/.bash_profile
trash ~/.gitconfig
trash ~/.global_ignore
trash ~/.oh-my-zsh.sh
trash ~/.tmux.conf
trash ~/.zshenv
trash ~/.zshrc

brew gem uninstall coderay
brew gem uninstall rouge

brew gem uninstall neovim

npm uninstall jsonlint -g
pip3 uninstall vim-vint
brew uninstall shellcheck

pip3 uninstall neovim

brew cask uninstall \
    google-chrome \
    jotta

# QuickLook plugins
brew cask uninstall \
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

brew uninstall \
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
