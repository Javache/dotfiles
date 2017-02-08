PROMPT='%{$fg[cyan]%}%m%{$reset_color%} %{$fg[green]%}%~%{$reset_color%} $(_dotfiles_scm_info)%(!.#.▸) '
ZSH_THEME_SVN_PROMPT_PREFIX="svn:("
ZSH_THEME_SVN_PROMPT_DIRTY="*"
ZSH_THEME_SVN_PROMPT_CLEAN=""
ZSH_THEME_SVN_PROMPT_SUFFIX=') '

_dotfiles_scm_info()
{
  # find out if we're in a git or hg repo by looking for the control dir
  local d git hg fmt scm_name
  d=$PWD
  while : ; do
    if test -d "$d/.git" ; then
      git=$d
      break
    elif test -d "$d/.hg" ; then
      hg=$d
      break
    fi
    test "$d" = / && break
    d=$(cd -P "$d/.." && echo "$PWD")
  done

  local br
  if test -n "$hg" ; then
    local extra
    if [ -f "$hg/.hg/bisect.state" ]; then
      extra="|BISECT"
    elif [ -f "$hg/.hg/histedit-state" ]; then
      extra="|HISTEDIT"
    elif [ -f "$hg/.hg/graftstate" ]; then
      extra="|GRAFT"
    elif [ -f "$hg/.hg/unshelverebasestate" ]; then
      extra="|UNSHELVE"
    elif [ -f "$hg/.hg/rebasestate" ]; then
      extra="|REBASE"
    elif [ -d "$hg/.hg/merge" ]; then
      extra="|MERGE"
    fi
    local dirstate=$(test -f $hg/.hg/dirstate && \
      hexdump -vn 20 -e '1/1 "%02x"' $hg/.hg/dirstate || \
      echo "empty")
    local current="$hg/.hg/bookmarks.current"
    if  [[ -f "$current" ]]; then
      br=$(cat "$current")
      # check to see if active bookmark needs update
      local marks="$hg/.hg/bookmarks"
      if [ -f "$hg/.hg/sharedpath" ]; then
          marks="`cat $hg/.hg/sharedpath`/bookmarks"
      fi
      if [[ -z "$extra" ]] && [[ -f "$marks" ]]; then
        local markstate=$(grep --color=never " $br$" "$marks" | cut -f 1 -d ' ')
        if [[ $markstate != $dirstate ]]; then
          extra="|UPDATE_NEEDED"
        fi
      fi
    else
      br=$(echo $dirstate | cut -c 1-7)
      local remote="$hg/.hg/remotenames"
      if [ -f "$hg/.hg/sharedpath" ]; then
          remote="`cat $hg/.hg/sharedpath`/remotenames"
      fi
      if [[ -f "$remote" ]]; then
        local marks=$(grep --color=never "^$dirstate bookmarks" "$remote" | \
          cut -f 3 -d ' ' | sed 's/^remote\///' | paste -s -d, - )
        if [[ -n "$marks" ]]; then
          br="$marks"
        fi
      elif [[ -f $hg/.hg/branch ]]; then
        local branch
        branch=$(cat $hg/.hg/branch)
        if [[ $branch != "default" ]]; then
          br="$br|$branch"
        fi
      fi
    fi
    br="$br$extra"
  elif test -n "$git" ; then
    if test -f "$git/.git/HEAD" ; then
      read br < "$git/.git/HEAD"
      case $br in
        ref:\ refs/heads/*) br=${br#ref: refs/heads/} ;;
        *) br=$(echo $br | cut -c 1-7) ;;
      esac
      if [ -f "$git/.git/rebase-merge/interactive" ]; then
        b="$(cat "$git/.git/rebase-merge/head-name")"
        b=${b#refs/heads/}
        br="$br|REBASE-i|$b"
      elif [ -d "$git/.git/rebase-merge" ]; then
        b="$(cat "$git/.git/rebase-merge/head-name")"
        b=${b#refs/heads/}
        br="br|REBASE-m|$b"
      else
        if [ -d "$git/.git/rebase-apply" ]; then
          if [ -f "$git/.git/rebase-apply/rebasing" ]; then
            br="$br|REBASE"
          elif [ -f "$git/.git/rebase-apply/applying" ]; then
            br="$br|AM"
          else
            br="$br|AM/REBASE"
          fi
        elif [ -f "$git/.git/MERGE_HEAD" ]; then
          br="$br|MERGE"
        elif [ -f "$git/.git/BISECT_LOG" ]; then
          br="$br|BISECT"
        fi
      fi
    fi
  fi
  if [ -n "$br" ]; then
    scm_name=$((test -n "$hg" && echo "hg") || echo "git")
    printf "%s:(%s) " "$scm_name" "$br"
  fi
}

local return_code="%(?..%{$fg[red]%}%? ↵ %{$reset_color%})"
RPROMPT='${return_code} [%*]'
