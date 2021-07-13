# Init completion and make `compdef` available
autoload -Uz compinit
compinit

# Babashka
_bb_tasks() {
    local matches=(`bb tasks |tail -n +3 |cut -f1 -d ' '`)
    compadd -a matches
    _files # autocomplete filenames as well
}

compdef _bb_tasks bb
