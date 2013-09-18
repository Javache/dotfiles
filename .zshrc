# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="javache"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git svn brew bundler gem osx rbenv)

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source $HOME/.exports
source $HOME/.functions

# Don't share command history between tabs
setopt no_share_history
autoload -U zmv

# Shell integration
eval "$(hub alias -s)"
