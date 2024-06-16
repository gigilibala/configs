#!/bin/zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-syntax-highlighting
  fast-syntax-highlighting
  zsh-autocomplete
)

source $HOME/.oh-my-zsh/oh-my-zsh.sh

#alias emacs='emacsclient -t'
export ALTERNATE_EDITOR=''
export EDITOR='emacs'
export SVN_EDITOR='emacs'
alias k='kubectl'
alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -aG'
alias lla='ls -alG'

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
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Setup Android Studio
export ANDROID_HOME="${HOME}/Library/Android/sdk"
export PATH="${PATH}:${ANDROID_HOME}/platform-tools"
export PATH="${PATH}:${ANDROID_HOME}/emulator"

# Setup Java
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"

# Setup ruby
eval "$(rbenv init - zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/amin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/amin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/amin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/amin/google-cloud-sdk/completion.zsh.inc'; fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
