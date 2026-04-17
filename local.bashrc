# Enable custom colors
export BLACK='\033[0;30m'
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export MAGENTA='\033[0;35m'
export CYAN='\033[0;36m'
export GRAY='\033[0;37m'
export LIGHTGRAY='\033[1;30m'
export LIGHTRED='\033[1;31m'
export LIGHTGREEN='\033[1;32m'
export LIGHTYELLOW='\033[1;33m'
export LIGHTBLUE='\033[1;34m'
export LIGHTMAGENTA='\033[1;35m'
export LIGHTCYAN='\033[1;36m'
export WHITE='\033[1;37m'
export ORANGE='\033[38;5;208m'
export PINK='\033[38;5;213m'
export PURPLE='\033[38;5;141m'
export TEAL='\033[38;5;37m'
export GOLD='\033[38;5;220m'
export DEFAULT='\033[0m'

if [ "$USER" = "root" ]; then
    ucolor="\[${LIGHTRED}\]"
else
    ucolor="\[${LIGHTGREEN}\]"
fi

checked='✓'
ballot='✗'

__parse_git_branch() {
    git rev-parse --is-inside-work-tree &>/dev/null || return

    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD)

    dirty=""
    staged=""

    git diff --quiet --ignore-submodules HEAD 2>/dev/null || dirty="*"
    git diff --cached --quiet 2>/dev/null || staged="+"

    printf "%s%s%s" "$branch" "$staged" "$dirty"
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
        status_icon="\[${LIGHTGREEN}\]${checked}"
    else
        status_icon="\[${LIGHTRED}\]${ballot}"
    fi

    status_text="${exit_code} ${status_icon}\[${WHITE}\]|"

    branch="$(__parse_git_branch)"
    if [ -n "$branch" ]; then
        git_info="\[${LIGHTYELLOW}\]@${branch}"
    fi

    venv="$(__python_venv_info)"
    if [ -n "$venv" ]; then
        venv_info=" \[${PURPLE}\][${venv}]"
    fi

    PS1="${status_text} ${ucolor}\u@\h\[${WHITE}\]${venv_info} \[${LIGHTBLUE}\]\w${git_info}\[${WHITE}\]: \[${DEFAULT}\]"
    PS2="${ucolor}# \[${WHITE}\]:\W\$ \[${DEFAULT}\]"
}

PROMPT_COMMAND=__prompt_command

# Color support and aliases
if [ -x /usr/bin/dircolors ]; then
    test -r "$HOME/.dircolors" && eval "$(dircolors -b "$HOME/.dircolors")" || eval "$(dircolors -b)"

    alias grep='grep --color=always'
    alias fgrep='fgrep --color=always'
    alias egrep='egrep --color=always'
fi

if [ -d $HOME/.local/.bashscripts]; then
    export PATH="$PATH:$HOME/.local/.bashscripts"
fi
