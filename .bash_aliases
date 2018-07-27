alias ls='ls -FN --color=auto'
alias pgrep='pgrep -af'
alias git=hub

alias testing-repo-list='pacman --color=always -Sl {,community-}testing|grep -F "[installed]"'
alias git-pr-setup='git config --local --add remote.origin.fetch '\''+refs/pull/*/head:refs/pull/*'\'''
# Check for updates to git packages
alias gitpkgs-refresh='(cd ~/git/pkgbuilds; for i in *-git/; do if [[ $i =~ (calibre|qbittorrent)-.* ]]; then true; else (cd $i && makepkg); fi; done)'
alias gitpkgs-refresh-aur='(cd /var/aur/; for i in *-git/; do if [[ $i =~ (excludes)-.* ]]; then true; else (cd $i && makepkg); fi; done)'

# Make diff like git-diff
diff () {
    colordiff "$@" | /usr/share/git/diff-highlight/diff-highlight | less -R
}
# Super-simple AUR wrapper
aurgen() {
    git clone aur:${1}
}
# View raw asp(1) package contents with pure git
alias wasp='git -C "${ASPROOT:-/var/cache/asp}"'
# Test local dev changes
makepkg-wrapper() {
    if alias makepkg > /dev/null 2>&1; then
        unalias makepkg
    else
        alias makepkg=~/git/archlinux/pacman/scripts/makepkg-wrapper
    fi
}
# Erroring on stupid errors is stupid. Also make FS#xxxxx work with Arch bugs.
html2text()
{
    local args=("$@")
    args=("${args[@]/FS\#/https://bugs.archlinux.org/task/}")
    /usr/bin/html2text --decode-errors=ignore "${args[@]}"
}
# Simple command-line remote image viewer
xloadimage()
{
    local file
    if [[ -f "$1" ]]; then
        file="$1"
    else
        file="/tmp/${1##*/}"
        wget -O "$file" "$1"
    fi
    /usr/bin/xloadimage "$file"
}
# Python virtualenv wrapper as a subshell
vactivate() {
	local path=~/.venv/$1

	if [[ ! -d $path ]]; then
		python -m venv $path --prompt "venv: $1"
	fi
	source "$path"/bin/activate; bash; deactivate
}
# alyptik function to ptpb with original command prepended
# See http://pb.gehidore.net/B0AG/sh
cptpb ()
{
    local pchar;
    [[ "$EUID" -eq 0 ]] && pchar='# ' || pchar='$ ';
    if [[ -n "$ZSH_NAME" ]]; then
        cat <(printf "%s\n" "${pchar}${history[$HISTCMD]}" | sed "s/ *| *cptpb.*//") - <(echo) | tee /dev/stderr | curl -F"c=@-" https://pb.gehidore.net 2> /dev/null | tee >(awk '/https/ {sub("url: ",""); print}' | 			awk 'NR>1{print PREV} {PREV=$0} END{printf("%s",$0)}' | 			xsel -ib);
    else
        if [[ -n "$BASH" ]]; then
            cat <(printf "%s\n" "${pchar}$(history 1 | sed "s/^ *[0-9]* *\(.*[^ ]\) *| *cptpb.*/\1/")") - <(echo) | tee /dev/stderr | curl -F"c=@-" https://pb.gehidore.net 2> /dev/null | tee >(awk '/https/ {sub("url: ",""); print}' | 			awk 'NR>1{print PREV} {PREV=$0} END{printf("%s",$0)}' | 			xsel -ib);
        else
            printf "$(tput setaf 9)$(tput bold)%s$(tput sgr0)\n" 'Error: bash/zsh not found!';
            return 1;
        fi;
    fi
}

# nvchecker wrapper for release checking
nv() {
    local cfg=$HOME/.config/nvchecker.ini
    local act=${1:-checker}; shift

    nv$act "$cfg" "$@"
}

aurdupes() {
    comm -12 <(pacman -Sql core extra community multilib| sort) <(aurgrep '' | sort )
}
