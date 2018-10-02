#!/usr/bin/env bash

casks=(
  visual-studio-code
  google-chrome
  slack
  webstorm
  pycharm
  datagrip
  spotify
  hyper
  stremio
  docker
  iterm2
  java
  github-desktop
  font-hack
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

function mutate_vim {
  git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
  sh ~/.vim_runtime/install_awesome_vimrc.sh
  echo "Vim is good to go :)"
}

function download_dynamo {
    wget https://s3.eu-central-1.amazonaws.com/dynamodb-local-frankfurt/dynamodb_local_latest.tar.gz
    cp dynamodb_local_latest.tar.gz ~/.dynamodb
    cd ~/.dynamodb
    tar xvzf dynamodb_local_latest.tar.gz
    echo "Dynamo is done! You can run with dynamo-run alias"
}

function install_aws_cli {
  cd ~/.aws_temp
  curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
  unzip awscli-bundle.zip
  sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
}

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

function after_install {
    # Install Node Version Manager (nvm)
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
    # Install DynamoDB
    download_dynamo
    # Give Vim some protein
    mutate_vim
    # Install AWS CLI
    install_aws_cli
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
after_install
mv .bashrc ~/.bashrc
source ~/.bashrc


prompt "Install mac CLI [NOTE: Say NO to bash-completions since we have fzf]!"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/guarinogabriel/mac-cli/master/mac-cli/tools/install)"
