#! /bin/sh

for source in "$@"; do
    if file -bL "$source" | grep -q "text"; then
        source-highlight --failsafe --infer-lang -f esc --style-file=esc.style -i "$source"
    else
        lesspipe.sh "$source"
    fi
#    case $source in
#        *ChangeLog|*changelog)
#            source-highlight --failsafe -f esc --lang-def=changelog.lang --style-file=esc.style -i "$source" ;;
#        *Makefile|*makefile)
#            source-highlight --failsafe -f esc --lang-def=makefile.lang --style-file=esc.style -i "$source" ;;
#        *.tar|*.tgz|*.gz|*.bz2|*.xz)
#            lesspipe.sh "$source" ;;
#        *)
#            source-highlight --failsafe --infer-lang -f esc --style-file=esc.style -i "$source" ;;
#     esac
done
