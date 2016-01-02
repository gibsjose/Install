# OS X Automated Install
This `bash` script automates the installation of OS X applications and command line tools by using `brew` and `brew cask` to install from a list of desired formulae and casks.

The primary motivation for this project is to reduce the normal frustration of reinstalling all of your software and command line tools every time OS X is updated and a clean-install is performed.

## Usage
To run, simply overwrite `brew-taps.txt`, `brew-formulae.txt`, and `brew-casks.txt` with your own formulae and casks lists.

If you would like to generate a list of installed brew taps, formulae, and casks on an existing machine, simply run:

```bash
brew tap > brew-taps.txt
brew leaves > brew-formulae.txt
brew cask list > brew-casks.txt
```

Once you have the lists all set, just run the script:

```bash
./install
```

## Operation
The script first installs Xcode's command line tools, and then attempts to install first `brew`, and then `brew cask`, before installing the formulae and casks located in `brew-formulae.txt` and `brew-casks.txt`.

By default, the script prompts the user before installing anything.

After installing all formulae and casks, the script displays a reminder of all Appstore Applications that should be installed, as well as Google Chrome Extensions.

To comment out a formula or cask, simply prefix the entry with '#', as you would with any `bash` comment.

```bash
...
alfred
atom
# skype
google-chrome
...
```
