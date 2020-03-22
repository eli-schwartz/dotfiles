#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

_prependpath() {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            export PATH="$1${PATH:+:$PATH}"
    esac
}

_prependpath "$HOME/.local/bin"
_prependpath "$HOME/bin"
