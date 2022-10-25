#!/bin/zsh

alias emacs='emacsclient -t'
export ALTERNATE_EDITOR=''
export EDITOR='emacsclient -t'
export SVN_EDITOR='emacsclient -t'
export TERM=xterm-256color
alias k='kubectl'
alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -aG'
alias lla='ls -alG'

IGNOREEOF=10

# Setup a nice prompt.
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '(%b)'
precmd() { vcs_info }
setopt PROMPT_SUBST
export PROMPT='%F{magenta}%n%F{reset_color}@%F{magenta}%m%F{reset_color}:% %F{green}%~%F{reset_color} %F{yellow}${vcs_info_msg_0_}%F{reset_color}
$ '

# usage: mygrep <string>
function mygrep() {
  grep -HIir $@ ./ ;
}

# usage: grep-replace <src> <from> <to>
function grep-replace() {
  command="grep --exclude-dir=.git -rl '$2' $1 | xargs sed -i 's/$2/$3/g'"
  echo $command
  eval $command
}

# usage: grep-replace <src> <from> <to>
function grep-replace-file() {
  command="grep --exclude-dir=.git  -rl '$2' $1 | xargs sed -i 's|$2|$3|g'"
  echo $command
  eval $command
}

if command -v go 1>/dev/null 2>&1; then
export GOPATH="${HOME}/.go"
export GOBIN="${GOPATH}/bin"
export PATH="${PATH}:${GOBIN}"
fi

# Setup Python
# alias python='python3'
# alias pip='pip3'
if command -v python3 1>/dev/null 2>&1; then
  export PATH="${PATH}:$(python3 -m site --user-base)/bin"
fi

# I think this only works if you have installed pyenv.
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Setup NVM for node
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"  # This loads nvm
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Setup yarn global directory.
if command -v yarn 1>/dev/null 2>&1; then
  export PATH="${PATH}:$(yarn global bin)"
fi

# Setup Android Studio
export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="${ANDROID_HOME}"
export PATH="${ANDROID_HOME}/platform-tools:${PATH}"

# Setup Java
export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/Contents/Home"
