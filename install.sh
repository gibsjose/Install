#!/bin/bash

# @TODO Add -f option to override all `prompt(...)` barriers

# @TODO Check out articles on installing Xcode dev tools via CLI:
# https://apple.stackexchange.com/questions/107307/how-can-i-install-the-command-line-tools-completely-from-the-command-line
# List of all CLI tools installed: http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/

# @TODO Add the following to brew cask:
#   > bettersnaptool
#   > synergy

# Grab functions
source ./functions.sh

# Install Xcode and Developer Tools
if xcode-select -p; then
    echo "> Xcode Developer Tools already installed"
    echo
elif exists "xcode-select"; then
    if prompt 'xcode-select'; then
        echo "> Installing Xcode Developer Tools..."
        # xcode-select --install
        echo
    fi
fi

# Install 'brew'
if exists 'brew'; then
    echo "> 'brew' already installed"
    echo
elif exists 'ruby'; then
    if exists 'curl'; then
        if prompt 'brew'; then
            echo "> Installing 'brew'"
            # ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            BREW_DIR=`command -v brew`
            echo "  Installed 'brew' to $BREW_DIR"
            echo
        fi
    fi
fi

# Install 'brew cask'
if exists 'brew-cask'; then
    echo "> 'brew-cask' already installed"
    echo
elif exists 'brew'; then
    if prompt 'brew cask'; then
        echo "> Installing 'brew cask'"
        # brew install caskroom/cask/brew-cask
        BREW_CASK_DIR=`command -v brew-cask`
        echo "  Installed 'brew cask' to $BREW_CASK_DIR"
        echo
    fi
fi

# Install 'brew' formulae
IFS=$'\n' read -d '' -r -a formulae < ./brew-formulae.txt
F=`printf "\n\t%s" "${formulae[@]}"`
# prompt $F

echo -e "> Installing 'brew' formulae:\n"
for formula in "${formulae[@]}"
do
    #Ignore commented lines
    if [[ $formula =~ ^[[:space:]]*\#.* ]]; then
        continue
        # echo -e "    [x] skipping $formula"
    else
        brew_formula $formula
    fi
done
echo

# Make sure to force install into /Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications --fontdir=/Library/Fonts"

# Install 'brew' casks
IFS=$'\n' read -d '' -r -a casks < ./brew-casks.txt
C=`printf "\n\t%s" "${casks[@]}"`
# prompt $C

echo -e "> Installing 'brew' casks:\n"
for cask in "${casks[@]}"
do
    #Ignore commented lines
    if [[ $cask =~ ^[[:space:]]*\#.* ]]; then
        continue
        # echo -e "    [x] skipping $cask"
    else
        brew_cask $cask
    fi
done

# Brew Cleanup
echo -ne "\n> Brew Cleanup..."
# brew cleanup --force
# rm -f -r /Library/Caches/Homebrew/*
echo -e " Done.\n"

# Show list of Appstore Apps to Install
IFS=$'\n' read -d '' -r -a apps < ./appstore.txt

echo -e "\n> Appstore Apps Reminder:\n"
for app in "${apps[@]}"
do
    echo -e "\t$app"
done

# Show list of Google Chrome Extensions to Install
echo -e "\n> Chrome Extensions Reminder (https://chrome.google.com/webstore/category/extensions?hl=en-US):\n"

IFS=$'\n' read -d '' -r -a extensions < ./chrome.txt
for extension in "${extensions[@]}"
do
    #Ignore commented lines
    if ! [[ $extension =~ ^[[:space:]]*\#.* ]]; then
        echo -e "\t$extension"
    fi
done

# Show list of Alfred Workflows to Install
echo -e "\n> Alfred Workflows Reminder (http://www.packal.org/):\n"

IFS=$'\n' read -d '' -r -a workflows < ./alfred.txt
for workflow in "${workflows[@]}"
do
    #Ignore commented lines
    if ! [[ $workflow =~ ^[[:space:]]*\#.* ]]; then
        echo -e "\t$workflow"
    fi
done
