PROMPT='%{$fg[cyan]%}%m%{$reset_color%} %{$fg[green]%}%~%{$reset_color%} $(git_prompt_info)$(hg_prompt_info)%(!.#.▸) '
ZSH_THEME_GIT_PROMPT_SUFFIX=') '
ZSH_THEME_HG_PROMPT_PREFIX='hg:('
ZSH_THEME_HG_PROMPT_SUFFIX=') '
ZSH_THEME_SVN_PROMPT_PREFIX="svn:("
ZSH_THEME_SVN_PROMPT_DIRTY="*"
ZSH_THEME_SVN_PROMPT_CLEAN=""
ZSH_THEME_SVN_PROMPT_SUFFIX=') '

function hg_get_branch_name() {
  if [ $(in_hg) ]; then
    local hg_root file
    hg_root=$(hg root)
    for file in "$hg_root/.hg/bookmarks.current" "$hg_root/.hg/branch" ; do
      test -f "$file" && cat "$file" && break
    done
  fi
}

local return_code="%(?..%{$fg[red]%}%? ↵ %{$reset_color%})"
RPROMPT='${return_code} [%*]'
