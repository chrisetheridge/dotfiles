# Copied from https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/functions.zsh#L117
function env_default() {
    [[ ${parameters[$1]} = *-export* ]] && return 0
    export "$1=$2" && return 3
}