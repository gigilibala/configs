#!/bin/bash

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
alias python='/usr/bin/python3'
alias pip='/usr/bin/pip3'

IGNOREEOF=10

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

function apply-cl() {
  ref=`git ls-remote cros | grep $1 | cut -f2`;
  git fetch cros $ref;
  git cherry-pick FETCH_HEAD;
}

export PATH="${PATH}:${HOME}/bin"

export GOPATH="${HOME}/go"
export GOBIN="${GOPATH}/bin"
export PATH="${PATH}:${GOBIN}"


if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


# Setup NVM for node
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"  # This loads nvm
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
