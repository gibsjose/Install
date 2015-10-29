#!/bin/bash

# @TODO Add -f option to override all `prompt(...)` barriers

# @TODO Check out articles on installing Xcode dev tools via CLI:
# https://apple.stackexchange.com/questions/107307/how-can-i-install-the-command-line-tools-completely-from-the-command-line
# List of all CLI tools installed: http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/

# @TODO Add the following to brew cask:
#   > bettersnaptool
#   > synergy
#   > yakyak (https://github.com/yakyak/yakyak)

# Grab functions
source ./functions.sh

# Install Xcode and Developer Tools
if xcode-select -p >/dev/null; then
    echo "> Xcode Developer Tools already installed"
    echo
elif exists "xcode-select"; then
    if prompt 'xcode-select'; then
        echo "> Install the Xcode Developer Tools and run this script again"
        xcode-select --install
        exit 0
    fi
fi

# Install 'brew'
if exists 'brew'; then
    echo "> Homebrew already installed"
    echo
elif exists 'ruby'; then
    if exists 'curl'; then
        if prompt 'Homebrew'; then
            echo "> Installing Homebrew"
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            BREW_DIR=`command -v brew`
            echo "  Installed Homebrew to $BREW_DIR"
            echo
        fi
    fi
fi

# Install 'brew cask'
if exists 'brew-cask'; then
    echo "> Homebrew Cask already installed"
    echo
elif exists 'brew'; then
    if prompt 'Homebrew Cask'; then
        echo "> Installing Homebrew Cask"
        brew install caskroom/cask/brew-cask
        BREW_CASK_DIR=`command -v brew-cask`
        echo "  Installed Homebrew Cask to $BREW_CASK_DIR"
        echo
    fi
fi

# Install 'brew' formulae
IFS=$'\n' read -d '' -r -a formulae < ./brew-formulae.txt

echo -e "> Installing Formulae:\n"
for formula in "${formulae[@]}"
do
    #Ignore commented lines
    if [[ $formula =~ ^[[:space:]]*\#.* ]]; then
        continue
        # echo -e "    [x] skipping $formula"
    else
        # Check if already installed
        if brew ls $formula >/dev/null 2>&1; then
            echo -e "\t$formula is already installed"
        else
            brew_formula $formula
        fi
    fi
done
echo

# Make sure to force install into /Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications --fontdir=/Library/Fonts"

# Install 'brew' casks
IFS=$'\n' read -d '' -r -a casks < ./brew-casks.txt

echo -e "> Installing Casks:\n"
for cask in "${casks[@]}"
do
    #Ignore commented lines
    if [[ $cask =~ ^[[:space:]]*\#.* ]]; then
        continue
        # echo -e "    [x] skipping $cask"
    else
        if brew cask ls $cask >/dev/null 2>&1; then
            echo -e "\t$cask is already installed"
        else
            brew_cask $cask
        fi
    fi
done

# Brew Cleanup
echo -ne "\n> Brew Cleanup..."
brew cleanup --force
rm -rf /Library/Caches/Homebrew/*
echo -e " Done.\n"
sleep 1

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
