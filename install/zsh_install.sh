#!/bin/sh
ZSH=${XDG_CONFIG_HOME:-$HOME/.config}/oh-my-zsh
ZSH_CUSTOM=$ZSH/custom

PLUGINS_INSTALL_ONLY=no
PLUGINS_UPDATE_ONLY=no
FULL_INSTALL=yes
HELP=no

plugins=(
    "/zsh-users/zsh-syntax-highlighting"
    "/agkozak/zsh-z"
    "/zsh-users/zsh-autosuggestions"
    "/changyuheng/zsh-interactive-cd"
    "/wfxr/forgit"
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

		ZSHRC=~/.zshrc
		if [ -f $ZSHRC ]; then 
			# the '-' allows the heredoc to be indented 
			# the ' surrounding the delimeter leads to not expanding the $VARs in the multiline comment
			cat <<- 'EOF' >> $ZSHRC
			if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
			  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
			fi
		
			[[ -z "$ZSH" ]] && export ZSH="${XDG_CONFIG_HOME:-$HOME/.config}/oh-my-zsh"
			[[ -z "$ZSH_CUSTOM" ]] && export ZSH_CUSTOM="$ZSH/custom"
			[[ -z "$ZSH_DOT_DIR" ]] && export ZSH_DOT_DIR="$HOME/dotfiles/zsh"
			
			source $ZSH_DOT_DIR/zshrc
			EOF
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
