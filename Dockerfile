FROM ls12styler/dind:19.03.1

# Install basics (HAVE to install bash for tpm to work)
RUN apk update && apk add -U --no-cache \
	bash zsh git git-perl neovim less curl bind-tools \
	man build-base su-exec shadow openssh-client

# Set Timezone
RUN apk add tzdata && \
    cp /usr/share/zoneinfo/Europe/Paris /etc/localtime && \
    echo "Europe/Paris" > /etc/timezone && \
    apk del tzdata

ENV HOME /

# Install tmux
COPY --from=ls12styler/tmux:latest /usr/local/bin/tmux /usr/local/bin/tmux

# Configure text editor - neovim!
RUN curl -fLo ${HOME}/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Consult the vimrc file to see what's installed
COPY init.vim ${HOME}/.config/nvim/init.vim
# Clone the git repos of Vim plugins
WORKDIR ${HOME}/.config/nvim/plugged/

RUN echo "clone vim plugins" && \
    git clone --depth=1 https://github.com/jiangmiao/auto-pairs && \
    git clone --depth=1 https://github.com/tpope/vim-vinegar && \
    git clone --depth=1 https://github.com/tpope/vim-commentary && \
    git clone --depth=1 https://github.com/tpope/vim-repeat && \
    git clone --depth=1 https://github.com/tpope/vim-surround && \
    git clone --depth=1 https://github.com/yuttie/comfortable-motion.vim && \
    git clone --depth=1 https://github.com/christoomey/vim-tmux-navigator && \
    git clone --depth=1 https://github.com/sickill/vim-pasta && \
    git clone --depth=1 https://github.com/Yggdroot/indentLine && \
    git clone --depth=1 https://github.com/wincent/loupe && \
    git clone --depth=1 https://github.com/mattn/webapi-vim && \
    git clone --depth=1 https://github.com/wincent/terminus && \
    git clone --depth=1 https://github.com/vim-scripts/vim-auto-save && \
    git clone --depth=1 https://github.com/ntpeters/vim-better-whitespace && \
    git clone --depth=1 https://github.com/editorconfig/editorconfig-vim && \
    git clone --depth=1 https://github.com/tpope/vim-projectionist && \
    git clone --depth=1 https://github.com/machakann/vim-highlightedyank && \
    git clone --depth=1 https://github.com/janko-m/vim-test && \
    git clone --depth=1 https://github.com/vim-scripts/ReplaceWithRegister && \
    git clone --depth=1 https://github.com/kana/vim-textobj-indent && \
    git clone --depth=1 https://github.com/kana/vim-textobj-line && \
    git clone --depth=1 https://github.com/kana/vim-textobj-user && \
    git clone --depth=1 https://github.com/junegunn/fzf.vim && \
    git clone --depth=1 https://github.com/airblade/vim-gitgutter && \
    git clone --depth=1 https://github.com/tpope/vim-fugitive && \
    git clone --depth=1 https://github.com/shumphrey/fugitive-gitlab.vim && \
    git clone --depth=1 https://github.com/tpope/vim-rhubarb && \
    git clone --depth=1 https://github.com/altercation/vim-colors-solarized && \
    git clone --depth=1 https://github.com/vim-airline/vim-airline && \
    git clone --depth=1 https://github.com/vim-airline/vim-airline-themes && \
    git clone --depth=1 https://github.com/edkolev/tmuxline.vim

# In the entrypoint, we'll create a user called `me`
WORKDIR ${HOME}

# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /.fzf && /.fzf/install --all

# Setup my $SHELL
ENV SHELL /bin/zsh
# Install oh-my-zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN wget https://gist.githubusercontent.com/xfanwu/18fd7c24360c68bab884/raw/f09340ac2b0ca790b6059695de0873da8ca0c5e5/xxf.zsh-theme -O ${HOME}/.oh-my-zsh/custom/themes/xxf.zsh-theme

# Install cobalt2 theme
RUN git clone https://github.com/wesbos/Cobalt2-iterm.git && \
      cp Cobalt2-iterm/cobalt2.zsh-theme ~/.oh-my-zsh/themes/ && \
      rm -rf Cobalt2-iterm

# Copy ZSh config
COPY zshrc ${HOME}/.zshrc

# Install TMUX
COPY tmux.conf ${HOME}/.tmux.conf
RUN git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm && \
    ${HOME}/.tmux/plugins/tpm/bin/install_plugins

# Copy git config over
COPY gitconfig ${HOME}/.gitconfig

# Entrypoint script creates a user called `me` and `chown`s everything
COPY entrypoint.sh /bin/entrypoint.sh

# Set working directory to /workspace
WORKDIR /workspace

# Default entrypoint, can be overridden
CMD ["/bin/entrypoint.sh"]
