" XDG Environment For VIM
" =======================
"
" References
" ----------
"
" - http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html#variables
" - http://tlvince.com/vim-respect-xdg
"

if exists("g:has_xdg")
    finish
endif

let g:has_xdg = 1

if empty($XDG_CACHE_HOME)
    let $XDG_CACHE_HOME = expand('~/.cache')  " expand tilde -> $HOME
endif
if empty($XDG_CONFIG_HOME)
    let $XDG_CONFIG_HOME = expand('~/.config')  " expand tilde -> $HOME
endif

if !isdirectory($XDG_CACHE_HOME . "/vim/swap")
    call mkdir($XDG_CACHE_HOME . "/vim/swap", "p")
endif
set directory=$XDG_CACHE_HOME/vim/swap//,/var/tmp//,/tmp//

if !isdirectory($XDG_CACHE_HOME . "/vim/backup")
    call mkdir($XDG_CACHE_HOME . "/vim/backup", "p")
endif
set backupdir=$XDG_CACHE_HOME/vim/backup//,/var/tmp//,/tmp//
" Double slash does not actually work for backupdir, here's a fix
au BufWritePre * let &backupext='@'.substitute(substitute(substitute(expand('%:p:h'), '/', '%', 'g'), '\', '%', 'g'), ':', '', 'g')

" see :help persistent-undo
if !isdirectory($XDG_CACHE_HOME . "/vim/undo")
    call mkdir($XDG_CACHE_HOME . "/vim/undo", "p")
endif
set undodir=$XDG_CACHE_HOME/vim/undo//,/var/tmp//,/tmp//
set undofile

set viminfo+=n$XDG_CACHE_HOME/vim/viminfo

" Chicken-and-egg problem. Which comes first, the runtimepath or the plugin?
if isdirectory($XDG_CONFIG_HOME . "/vim")
    set runtimepath-=~/.vim
    set runtimepath^=$XDG_CONFIG_HOME/vim
    set runtimepath-=~/.vim/after
    set runtimepath+=$XDG_CONFIG_HOME/vim/after
    if filereadable($XDG_CONFIG_HOME . "/vim/vimrc")
        source $XDG_CONFIG_HOME/vim/vimrc
        let $MYVIMRC = expand($XDG_CONFIG_HOME . "/vim/vimrc")
    endif
endif
