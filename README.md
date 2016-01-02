# OS X Automated Install
This `bash` script automates the installation of OS X applications and command line tools by using `brew` and `brew cask` to install from a list of desired formulae and casks.

The primary motivation for this project is to reduce the normal frustration of reinstalling all of your software and command line tools every time OS X is updated and a clean-install is performed.

## Setup
To setup the script, simply overwrite `brew-taps.txt`, `brew-formulae.txt`, and `brew-casks.txt` with your own tap, formula, and cask lists.

If you would like to generate a list of installed taps, formulae, and casks on an existing machine, simply run:

```bash
brew tap > brew-taps.txt
brew leaves > brew-formulae.txt
brew cask list > brew-casks.txt
```

To comment out a tap, formula, or cask, simply prefix the entry with '#', as you would with any `bash` comment.

```bash
...
alfred
atom
# skype
google-chrome
...
```

## Usage
Once you have the lists all set, just run the script:

```bash
./install.sh
```

> **Note**: By default, the script prompts the user before installing anything.

## Operation
The script installs the following, in order:
1. Xcode's command line tools
2. `brew`
3. `brew cask`
3. External taps located in `brew-taps.txt`
4. Formulae located in `brew-formulae.txt`
5. Casks located in `brew-casks.txt`
6. Display reminder of all Appstore Applications and Google Chrome Extensions
