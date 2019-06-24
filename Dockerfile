FROM ubuntu:18.04
MAINTAINER Truls Aagaard <truls.aa@gmail.com>

# Better terminal support
ENV TERM screen-256color
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /Projects

COPY dockerInstall.sh ./
RUN chmod +x dockerInstall.sh && ./dockerInstall.sh

COPY ./nvim/init.vim ./dotfiles/nvim
COPY ./nvim/vimrc/plugins.vim ./dotfiles/nvim/vimrc
RUN nvim +'PlugInstall --sync' +qall > /dev/null 2>&1

CMD "zsh"

