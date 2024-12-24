# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
DISABLE_MAGIC_FUNCTIONS=true
ZSH_THEME="javache"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(gitfast svn mercurial macos)

# eval "$(rbenv init -)"

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source $HOME/.exports
source $HOME/.functions
source $HOME/.fbchef/environment
source $HOME/.iterm2_shell_integration.zsh
source $HOME/.cargo/env

setopt inc_append_history
setopt hist_ignore_space
setopt no_share_history

autoload -U zmv
