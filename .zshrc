export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="javache"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git svn brew bundler gem rbenv osx)

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source $HOME/.functions

# Don't share command history between tabs
setopt no_share_history

# Customize to your needs...
export PATH=$HOME/Scripts:$HOME/.cabal/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
export NODE_PATH="/usr/local/lib/node_modules"
export MANPATH="/usr/local/share/man:$MANPATH"
export INFOPATH="/usr/local/share/info:$INFOPATH"
export ANDROID_SDK_ROOT=/usr/local/Cellar/android-sdk/r20.0.1
export CLICOLOR=1
export EDITOR="subl -w"
export MANPAGER="col -b | bcat"
export PYTHONSTARTUP="$HOME/.pystartup"

# Shell integration
eval "$(hub alias -s)"
eval "$(rbenv init - --no-rehash)"
