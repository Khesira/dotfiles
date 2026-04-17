alias cd..='cd ..'
alias cd...='cd ../..'

alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'

alias psa='ps aux'
alias psg='ps aux | grep'

alias lsports='lsof -Pan -i tcp -i udp'
alias lsportsg='lsof -Pan -i tcp -i udp | grep'
alias tulpen="ss -tulpen"
alias dmesg='sudo dmesg -T'

alias venv='if [[ -d .venv ]]; then . .venv/bin/activate; else echo -e "${RED} No .venv folder found${DEFAULT}"; fi'

alias ls='/bin/ls --color=always'
alias l='ls -lh'
alias la='ls -la'

alias bashconf='vim $HOME/.bashrc'
alias aliasconf='vim $HOME/.bash_aliases'
