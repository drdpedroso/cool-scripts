#!/usr/bin/env bash

casks=(
  visual-studio-code
  google-chrome
  slack
  pycharm
  datagrip
  spotify
  hyper
  stremio
  docker
  iterm2
  github-desktop
)

brews=(
  git
  python
  python3
  bash-completion
  vim --with-override-system-vi
  wget --with-iri
)

git_configs=(
  "pull.rebase true"
  "user.name Eduardo Pedroso"
  "user.email drdpedroso@gmail.com"
)


function prompt {
  echo $1
}

function install {
  cmd=$1
  shift
  for pkg in $@;
  do
    exec="$cmd $pkg"
    prompt "Execute: $exec"
    if ${exec} ; then
      echo "Installed $pkg"
    else
      echo "Failed to execute: $exec"
    fi
  done
}

prompt "Installing HomeBrew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

prompt "Install brew packages"
brew info ${brews[@]}
install 'brew install' ${brews[@]}

prompt "Set git defaults"
for config in "${git_configs[@]}"
do
  git config --global ${config}
done

prompt "Install software"
brew tap caskroom/versions
brew cask info ${casks[@]}
install 'brew cask install' ${casks[@]}
mv .bashrc ~/.bashrc
mv .hyper.js ~/.hyper.js
mv .hyper_plugins ~/.hyper_plugins
mv .zshrc ~/.zshrc
mv .zxventures ~/.zxventures
source ~/.bashrc
source ~/.zshrc


prompt "Install mac CLI [NOTE: Say NO to bash-completions since we have fzf]!"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/guarinogabriel/mac-cli/master/mac-cli/tools/install)"
