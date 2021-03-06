#!/bin/bash

# Copyright (c) 2018 James Thompson <james@thomps.onl>
# This code is licensed under the MIT license (see LICENSE for details)

SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cat $SOURCE_DIR/README

if [[ -z $(command -v brew) ]]
  then
    echo 'Starting installation of Homebrew...'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [[ -n $(command -v brew) ]]
  then
    echo 'Installing GNU tools...'
    brew install coreutils
    brew install diffutils
    brew install ed --with-default-names
    brew install findutils --with-default-names
    brew install gawk
    brew install gnu-indent --with-default-names
    brew install gnu-sed --with-default-names
    brew install gnu-tar --with-default-names
    brew install gnu-which --with-default-names
    brew install gnutls
    brew install grep --with-default-names
    brew install gzip
    brew install screen
    brew install watch
    brew install wdiff --with-gettext
    brew install wget
    brew install bash
    brew install bash-git-prompt
    brew install gpatch
    brew install less
    brew install m4
    brew install make --with-default-names
    brew install nano
    brew install git
    brew install openssh
    brew install rsync
    brew install unzip
    brew install vim --override-system-vi

    if [[ -z $(brew cask list | grep setapp) ]]
      then
        echo -e "Installing Setapp"
        brew cask install setapp
        open /usr/local/Caskroom/setapp/1.18.1,1539860348/Install\ Setapp.app
    fi

    if [[ -z $(brew cask list | grep visual-studio-code) ]]
      then
        echo -e "Installing Visual Studio Code"
        brew cask install visual-studio-code
    fi

    if [[ -z $(brew cask list | grep jetbrains-toolbox) ]]
      then
        echo -e "Installing JetBrains Toolbox"
        brew cask install jetbrains-toolbox
    fi

    if [[ -z $(brew cask list | grep keybase) ]]
      then
        echo -e "Installing Keybase"
        brew cask install keybase
    fi

    echo -e "Installing Homebrew fonts"
    brew tap homebrew/cask-fonts
    brew cask install font-fira-code
    brew cask install font-fira-mono
    brew cask install font-fira-sans

    echo -e "Installing rbenv"
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    cd ~/.rbenv && src/configure && make -C src
    git clone git://github.com/tpope/rbenv-readline.git $HOME/.rbenv/plugins/rbenv-readline
fi

echo 'Symlinking Bash profile into place...'
ln -nfs $SOURCE_DIR/bash/profile $HOME/.bash_profile

echo 'Configuring global git configurations...'
git config --global user.name "James Thompson"
git config --global user.email "james@thomps.onl"
git config --global core.excludesfile $SOURCE_DIR/.gitignore

echo 'Configuring global git aliases...'
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'

echo 'Reloading shell settings...'
source $HOME/.bash_profile

echo -e "Done \xE2\x9C\x94"
