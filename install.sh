#!/bin/bash

# Default settings
SKIP_ZSHRC=${SKIP_ZSHRC:-no}     # add XDG settings and PATH to zshrc. Skip with --skip-zsh
SKIP_BASHRC=${SKIP_BASHRC:-no}   # add XDG settings and PATH to bashrc. Skip with --skip-bash

# Other settings
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )" # get path to this file
RC_FILE=$HOME/.bashrc


appendXDGandPATHToRcFile() {
    # the '-' allows the heredoc to be indented 
    # the ' surrounding the delimeter leads to not expanding the $VARs in the multiline comment
	cat <<- 'EOF' >> $RC_FILE

	[[ -z "$XDG_CONFIG_HOME" ]] && export XDG_CONFIG_HOME="$HOME/.config"
	[[ -z "$XDG_DATA_HOME" ]] && export XDG_DATA_HOME="$HOME/.local/share"
	export PATH=$HOME/.local/bin:/usr/local/bin:bin$PATH
	EOF
}


installEnvironment() {
# update sources
sudo apt update && apt upgrade -y
$SCRIPTPATH/install/zsh_install.sh
$SCRIPTPATH/install/python_install.sh
$SCRIPTPATH/install/utils_install.sh
$SCRIPTPATH/install/nvim_install.sh
}


main() {
    # Parse arguments
    while [ $# -gt 0 ]; do
        case $1 in
            --skip-zsh) ZSHRC=yes ;;
            --skip-bash) BASHRC=yes ;;
        esac
        shift
    done

    if [ $SKIP_BASHRC = no ]; then
        RC_FILE=$HOME/.bashrc
        if [ ! -f $RC_FILE ]; then 
            echo "$RC_FILE not found. Creating new!"
            touch $RC_FILE
        fi
        appendXDGandPATHToRcFile
    fi

    if [ $SKIP_ZSHRC = no ]; then
        RC_FILE=$HOME/.zshrc
        if [ -f $RC_FILE ]; then 
            mv $RC_FILE $RC_FILE.old
            echo "$RC_FILE found. Create backup $RC_FILE.old!"
        else
            echo "$RC_FILE not found. Creating new!"
            touch $RC_FILE
        fi
        appendXDGandPATHToRcFile
    fi

    installEnvironment
}

main "$@"
