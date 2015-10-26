# OS X Automated Install
25 Oct 2015

This `bash` script automates the installation of OS X applications and command line tools by using `brew` and `brew cask` to install from a list of desired formulae and casks.

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
