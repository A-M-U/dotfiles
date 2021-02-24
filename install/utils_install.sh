#!/bin/bash
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )" # get path to this file

mkdir -p ~/.local/bin

# install current version of bat
cd /tmp
curl -LO https://github.com/sharkdp/bat/releases/download/v0.17.1/bat_0.17.1_amd64.deb
sudo dpkg -i bat_*_amd64.deb
cd -

# install fd and create a symlink because the installed binary is named fdfind due to a name clash
sudo apt install fd-find -y
ln -s /usr/bin/fdfind ~/.local/bin/fd

# the --all argument will install all without confirmation
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ${XDG_CONFIG_HOME:-$HOME/.config}/fzf
${XDG_CONFIG_HOME:-$HOME/.config}/fzf/install --all --xdg

# install tmux and create a symlink to the config
sudo apt install tmux -y
ln -s $SCRIPTPATH/../tmux/tmux.conf ~/.tmux.conf

#tmux plugins
git clone https://github.com/tmux-plugins/tmux-yank $HOME/.config/tmux/tmux-yank
sudo apt install tmuxinator -y

# install a faster grep alternative
sudo apt install silversearcher-ag -y

sudo apt install exuberant-ctags
