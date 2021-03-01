#!/bin/bash
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )" # get path to this file

ZSH=${XDG_CONFIG_HOME:-$HOME/.config}/oh-my-zsh
ZSH_CUSTOM=$ZSH/custom
ZSHRC=~/.zshrc

PLUGINS_INSTALL_ONLY=no
PLUGINS_UPDATE_ONLY=no
FULL_INSTALL=yes
HELP=no

plugins=(
    /zsh-users/zsh-syntax-highlighting
    /agkozak/zsh-z
    /zsh-users/zsh-autosuggestions
    /changyuheng/zsh-interactive-cd
    /wfxr/forgit
)

themes=("/romkatv/powerlevel10k")

# install zsh
installZsh() {
    sudo apt install zsh -y
    chsh -s $(which zsh)
    git clone https://github.com/ohmyzsh/ohmyzsh.git $ZSH
}


installPlugins(){
    for i in "${plugins[@]}"; do
        dirName=$(echo "$i" | awk -F "/" '{print $3}')
        if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$dirName ]; then
            git clone https://github.com$i ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$dirName
        fi
    done
}

updatePlugins(){
    for i in "${plugins[@]}"; do
        echo "Update Plugin: $i"
        dirName=$(echo "$i" | awk -F "/" '{print $3}')
        cd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$dirName
        git pull
        cd -
    done
}

installThemes(){
    for i in "${themes[@]}"; do
        dirName=$(echo "$i" | awk -F "/" '{print $3}')
        if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/$dirName ]; then
            git clone --depth=1 https://github.com$i ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/$dirName
        fi
    done
}

updateThemes(){
    for i in "${themes[@]}"; do
        echo "Update Theme: $i"
        dirName=$(echo "$i" | awk -F "/" '{print $3}')
        cd  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/$dirName
        git pull
        cd -
    done
}

prependPowerline10kSettingsToZshrc(){
    cat $ZSHRC > $ZSHRC.blub
    echo '# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.' > $ZSHRC
    echo '# Initialization code that may require console input (password prompts, [y/n]' >> $ZSHRC
    echo '# confirmations, etc.) must go above this block; everything else may go below.' >> $ZSHRC
    echo 'if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then' >> $ZSHRC
    echo '  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"' >> $ZSHRC
    echo -e "fi\n" >> $ZSHRC
    cat $ZSHRC.blub >> $ZSHRC
    rm $ZSHRC.blub
}

main() {
    # Parse arguments
    while [ $# -gt 0 ]; do
        case $1 in
            --install-plugins) PLUGINS_INSTALL_ONLY=yes; FULL_INSTALL=no ;;
            --update-plugins) PLUGINS_UPDATE_ONLY=yes; FULL_INSTALL=no ;;
            --help) HELP=yes; FULL_INSTALL=no;;
        esac
        shift
    done

    if [ $FULL_INSTALL = yes ]; then
        installZsh

        if [ -f $ZSHRC ]; then
            prependPowerline10kSettingsToZshrc

            echo '[[ -z "$ZSH" ]] && export ZSH="${XDG_CONFIG_HOME:-$HOME/.config}/oh-my-zsh"' >> $ZSHRC
            echo '[[ -z "$ZSH_CUSTOM" ]] && export ZSH_CUSTOM="$ZSH/custom"' >> $ZSHRC
            echo '[[ -z "$ZSH_DOT_DIR" ]] && export ZSH_DOT_DIR="'$SCRIPTPATH'/../zsh"' >> $ZSHRC

            echo "\n"
            echo 'source $ZSH_DOT_DIR/zshrc' >> $ZSHRC
        fi
        installPlugins
        installThemes
    elif [ $PLUGINS_INSTALL_ONLY = yes ]; then
        installPlugins
        installThemes
    elif [ $PLUGINS_UPDATE_ONLY = yes ]; then
        updatePlugins
        updateThemes
    elif [ $HELP = yes ]; then
        echo "--install-plugins     - Install plugins and themes only"
        echo "--update-plugins      - Update plugins and themes only"
    else
        echo "Selection not supported"
    fi
}

main "$@"
