# Non-interactive shells don't execute .zshrc
[[ $- == *i* ]] || source $HOME/.exports
