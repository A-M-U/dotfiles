#!/bin/bash

# install nvim as appimage (in sugguested location ${HOME}/Applications/ or ${HOME}/.local/bin/ or ${HOME}/bin/)
cd ~/.local/bin 
curl -LO https://github.com/neovim/neovim/releases/download/v0.4.4/nvim.appimage
chmod u+x nvim.appimage

# extract image to use it the same way in systems with and without fuse installed
./nvim.appimage --appimage-extract
ln -s squashfs-root/usr/bin/nvim nvim
cd -

pip3 install neovim

# Configure CoC
# Coc requires current verion of nodejs. Availabe ubuntu package is to old. Therefore get new nodjs sources before
# installinng. 
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install nodejs -y
sudo npm install -g neovim

# get plugin manager, setup nvim config and install plugins
sh -c 'git clone https://github.com/k-takata/minpac.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim/pack/minpac/opt/minpac'
ln -s ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/nvim/config ~/.config/nvim/config
~/.local/bin/nvim --headless +"call minpac#update()" +qa
~/.local/bin/nvim --headless +"CocInstall -sync coc-clangd  coc-cmake  coc-explorer  coc-json  coc-lists  coc-pyright coc-snippets coc-sh coc-vimlsp coc-yaml coc-yank" +qa

# create default local nvim config if none exists
LOCAL_VIMRC=~/.config/nvim/local.vim
if [ ! -f $LOCAL_VIMRC ]; then 
    PYTHON_PATH=$(which python3)
    echo "let g:python3_host_prog = '$PYTHON_PATH'" > $LOCAL_VIMRC
fi

