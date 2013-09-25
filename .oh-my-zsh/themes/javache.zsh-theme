PROMPT='%{$fg[cyan]%}%m%{$reset_color%} %{$fg[green]%}%~%{$reset_color%} $(git_prompt_info)$(svn_prompt_info)%(!.#.▸) '
ZSH_THEME_GIT_PROMPT_SUFFIX=') '
ZSH_THEME_SVN_PROMPT_PREFIX="svn:("
ZSH_THEME_SVN_PROMPT_DIRTY="*"
ZSH_THEME_SVN_PROMPT_CLEAN=""
ZSH_THEME_SVN_PROMPT_SUFFIX=') '

local return_code="%(?..%{$fg[red]%}%? ↵ %{$reset_color%})"
RPROMPT='${return_code} [%*]'
