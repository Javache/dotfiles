# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

git_prompt ()
{
  c_reset='\[\e[0m\]'
  c_git_clean='\[\e[36;1m\]'
  c_git_dirty='\[\e[31;1m\]'
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi

  git_branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')

  if git diff --quiet 2>/dev/null >&2; then
    git_color="$c_git_clean"
  else
    git_color="$c_git_dirty"
    git_branch="${git_branch}*"
  fi

  echo "${git_color}${git_branch}${c_reset}"
}

my_dotfiles_scm_info()
{
  # find out if we're in a git or hg repo by looking for the control dir
  local d git hg
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
    # portable "realpath" equivalent
    d=$(cd "$d/.." && echo "$PWD")
  done

  local br
  local scm
  if test -n "$hg" ; then
    scm='hg'
    local file
    for file in "$hg/.hg/bookmarks.current" "$hg/.hg/branch" ; do
      test -f "$file" && { read br < "$file" ; break; }
    done
  elif test -n "$git" ; then
    #br=$(git_prompt)
    scm='git'
    if test -f "$git/.git/HEAD" ; then
      read br < "$git/.git/HEAD"
      case $br in
        ref:\ refs/heads/*) br=${br#ref: refs/heads/} ;;
        *) # Lop off all of an SHA1 except the leading 7 hex digits.
           # Use this cumbersome notation (it's portabile) rather
           # than ${head:0:7}, which doesn't work with older zsh.
          br="DETACHED @ ${br%?????????????????????????????????}" ;;
      esac
    fi
  fi
  test -n "$br" && printf "%s:(%s) " "$scm" "$br" || :
}

export EDITOR='vim'
export CLICOLOR=1
export LSCOLORS='Gxfxcxdxbxegedabagacad'
export LS_COLORS='di=1;36;40:ln=35;40:so=32;40:pi=33;40:ex=91;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'

c_reset="\[$(tput sgr0)\]"
c_cyan="\[$(tput setaf 6)\]"
c_green="\[$(tput setaf 2)\]"
export PROMPT_COMMAND='PS1="${c_cyan}\h${c_reset} ${c_green}\w${c_reset} $(my_dotfiles_scm_info)▸ "'
