 # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
 export PATH="$PATH:$HOME/.rvm/bin"

 export ANDROID_HOME=/Users/eduardopedroso/Library/Android/sdk/
 export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

 parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
 }

 alias logp="git log --pretty --oneline"
 alias docker-sa="docker kill $(docker ps -q)"
 alias docker-ka="docker rm $(docker ps -a -q)"
 alias docker-rm="docker rmi $(docker images -q)"

 export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

 export NVM_DIR="$HOME/.nvm"
 [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
 [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
