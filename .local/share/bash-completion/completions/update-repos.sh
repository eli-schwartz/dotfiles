_update_repos ()
{
    local cur prev words cword;
    _init_completion || return;
    case $prev in
        -h | --help)
            return
        ;;
    esac;
    COMPREPLY=($(compgen -W " -r --remove -f --force -k --kernel $(pacman -Slq custom 2>/dev/null)" -- "${cur}"))
}

complete -F _update_repos update-repos.sh
