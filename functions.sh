# Prompt user to continue
prompt() {
    read -p "    Install $1? [Y/n] " -r

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
