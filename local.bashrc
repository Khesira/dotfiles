# Enable custom colors
BLACK='\[\033[0;30m\]'
RED='\[\033[0;31m\]'
GREEN='\[\033[0;32m\]'
YELLOW='\[\033[0;33m\]'
BLUE='\[\033[0;34m\]'
MAGENTA='\[\033[0;35m\]'
CYAN='\[\033[0;36m\]'
GRAY='\[\033[0;37m\]'
LIGHTGRAY='\[\033[1;30m\]'
LIGHTRED='\[\033[1;31m\]'
LIGHTGREEN='\[\033[1;32m\]'
LIGHTYELLOW='\[\033[1;33m\]'
LIGHTBLUE='\[\033[1;34m\]'
LIGHTMAGENTA='\[\033[1;35m\]'
LIGHTCYAN='\[\033[1;36m\]'
WHITE='\[\033[1;37m\]'
ORANGE='\[\033[38;5;208m\]'
PINK='\[\033[38;5;213m\]'
PURPLE='\[\033[38;5;141m\]'
TEAL='\[\033[38;5;37m\]'
GOLD='\[\033[38;5;220m\]'
DEFAULT='\[\033[0m\]'

if [ "$USER" = "root" ]; then
    ucolor="$LIGHTRED"
else
    ucolor="$LIGHTGREEN"
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

__python_venv_info() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        printf "%s" "$(basename "$VIRTUAL_ENV")"
    fi
}

__prompt_command() {
    local exit_code="$?"
    local status_icon
    local status_text
    local git_info=""
    local venv_info=""
    local branch

    if [ "$exit_code" -eq 0 ]; then
        status_icon="${LIGHTGREEN}${checked}"
    else
        status_icon="${LIGHTRED}${ballot}"
    fi

    status_text="${exit_code} ${status_icon}${WHITE}|"

    branch="$(__parse_git_branch)"
    if [ -n "$branch" ]; then
        git_info="${LIGHTYELLOW}@${branch}"
    fi

    venv="$(__python_venv_info)"
    if [ -n "$venv" ]; then
        venv_info=" ${PURPLE}[${venv}]"
    fi

    PS1="${status_text} ${ucolor}\u@\h${WHITE}${venv_info} ${LIGHTBLUE}\w${git_info}${WHITE}: ${DEFAULT}"
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