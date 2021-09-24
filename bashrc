#!/bin/bash
alias emacs='emacsclient -t'
export ALTERNATE_EDITOR=''
export EDITOR='emacsclient -t'
export SVN_EDITOR='emacsclient -t'
export TERM=xterm-256color
alias k='kubectl'


IGNOREEOF=10

#changing terminal prompt look
git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

is_inside_chroot() {
  if [[ -f "/etc/cros_chroot_version" ]]; then
    echo "(chroot)"
  fi
}

export PS1='\[\e[1;31m\]~{\[\e[1;35m\]\u\[\e[1;37m\]@\[\e[1;35m\]\h\[\e[1;37m\]:\[\e[1;34m\]$(is_inside_chroot)\[\e[1;32m\]\w\[\e[1;33m\]$(git_branch)\[\e[1;31m\]}~{\[\e[1;34m\D{%m/%e/%y}-\A\]\[\e[1;31m\]}~\n\[\e[0m\]$ '

# usage: mygrep <string>
function mygrep() { grep -HIir $@ ./ ; }

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

export PATH=$PATH:$HOME/usr/bin:/opt/android-studio/bin:$HOME/go/bin:$HOME/bin

if [[ -f /usr/share/autojump/autojump.sh ]]; then
    source /usr/share/autojump/autojump.sh
fi


function host() {
  cat "/home/ahassani/host$1"
}

function set-host() {
  echo $2 > "/home/ahassani/host$1"
}

function cros-scp() {
  scp  -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o IdentityFile=~/.ssh/testing_rsa $1 $2
}
