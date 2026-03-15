# Enable custom colors
BLACK='\[\033[1;30m\]'
RED='\[\033[1;31m\]'
GREEN='\[\033[1;32m\]'
YELLOW='\[\033[1;33m\]'
BLUE='\[\033[1;34m\]'
MAGENTA='\[\033[1;35m\]'
CYAN='\[\033[1;36m\]'
GRAY='\[\033[1;37m\]'
WHITE='\[\033[01;00m\]'
DEFAULT='\[\033[0m\]'

if [ "$USER" = "root" ]; then
    ucolor="$RED"
else
    ucolor="$GREEN"
fi

checked='✓'
ballot='✗'

__parse_git_branch() {
    local branch
    branch=$(git branch --show-current 2>/dev/null || true)
    if [ -n "$branch" ]; then
        printf '%s' "$branch"
    fi
}

__prompt_command() {
    local exit_code="$?"
    local status_icon
    local status_text
    local git_info=""
    local branch

    if [ "$exit_code" -eq 0 ]; then
        status_icon="${GREEN}${checked}"
    else
        status_icon="${RED}${ballot}"
    fi

    status_text="${WHITE}[${exit_code} ${status_icon}${WHITE}] "

    branch="$(__parse_git_branch)"
    if [ -n "$branch" ]; then
        git_info="${MAGENTA}[${branch}]"
    fi

    PS1="${status_text}${git_info}${ucolor}\u@${ucolor}\h${WHITE}:${BLUE}\w\$ ${DEFAULT}"
    PS2="${ucolor}# ${WHITE}:${WHITE}\W${WHITE}\$ ${DEFAULT}"
}

PROMPT_COMMAND=__prompt_command

# Color support and aliases
if [ -x /usr/bin/dircolors ]; then
    test -r "$HOME/.dircolors" && eval "$(dircolors -b "$HOME/.dircolors")" || eval "$(dircolors -b)"

    alias grep='grep --color=always'
    alias fgrep='fgrep --color=always'
    alias egrep='egrep --color=always'
fi