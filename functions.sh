# Prompt user to continue
prompt() {
    colour_yellow='\e[1;33m'
    colour_green='\e[1;32m'
    colour_off='\e[0m'
    prompt_var=$(printf "\t\b\b${colour_yellow}*${colour_off} Install $1? ${colour_green}[Y/n]${colour_off} ")
    read -p "$prompt_var" -r

    # Use this one in combo with the echo to skip having to press
    # <ENTER> after typing 'n' or 'Y'...
    #
    # read -p "    Install $1? [Y/n] " -n 1 -r
    # echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Y]$ ]]
    then
        echo
        return 0
    else
        return 1
    fi
}

# Check if executable exists in $PATH
# Print error and exit if it does not exist
exists() {
    command -v $1 >/dev/null 2>&1
    if [ $? -eq 1 ]; then
        # echo >&2 "! Error: '$1' not found";
        return 1
    else
        return 0
    fi
}

# Install brew taps
brew_tap() {
    if prompt $1; then
        echo -e "\tbrew tap $1"
        brew tap $1
        echo
    fi
}

# Install brew formula
brew_formula() {
    if prompt $1; then
        echo -e "\tbrew install $1"
        brew install $1
        echo
    fi
}

# Install brew cask
brew_cask() {
    if prompt $1; then
        echo -e "\tbrew cask install $1"
        brew cask install $1
        echo
    fi
}
