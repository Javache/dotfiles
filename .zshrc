# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="javache"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git svn mercurial brew bundler gem osx)

eval "$(rbenv init -)"

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source $HOME/.functions

# Don't share command history between tabs
setopt no_share_history
autoload -U zmv
