" Disable vi bugs
set nocompatible
" Vundle doesn't like this
filetype off

" Prefer the git protocol
let g:vundle_default_git_proto = 'git'
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin() " All plugin commands MUST start here

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Sensible defaults
" owned by pacman
" Plugin 'tpope/vim-sensible'

" updated ftplugins for git
" owned by pacman
" Plugin 'tpope/vim-git'

" Wrapper for using git in vim
" owned by pacman
" Plugin 'tpope/vim-fugitive'

" Git statusline
" owned by pacman
" Plugin 'airblade/vim-gitgutter'

" Auto-make endifs in scripts
" owned by pacman
" Plugin 'tpope/vim-endwise'

" Integrate unix file handling (auto chmod+x new files with a shebang)
" owned by pacman
" Plugin 'tpope/vim-eunuch'

" Show evil whitespace
Plugin 'vim-scripts/ShowTrailingWhitespace'

" Reopen at the last cursor position
Plugin 'farmergreg/vim-lastplace'

" Syntax checking for everything
" owned by pacman
" Plugin 'scrooloose/syntastic'

call vundle#end()            " Finished adding plugins

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
filetype plugin indent on    " turn filetype detection back on after vundle finishes

set t_Co=256 "Sets Vim to use 256 colors
colorscheme default

" vim doesn't know how to do this itself
" Don't use inscrutable light colorschemes in the dark
if has('gui_running')
    set background=light
else
    set background=dark
endif

" Set line numbers
" Current line is absolute, other lines are relative to current line.
set number
set relativenumber

" Tabs started annoying me
set expandtab
set shiftwidth=4
set tabstop=4

" Search settings
set incsearch "Start searching immediately
set hlsearch "Highlight search terms
set showmatch "Highlight matching parentheses
set ignorecase "Ignore case when searching
set smartcase

set autoindent smartindent

" keep a backup file
set backup
" sudoedit uses this instead of /tmp
set backupskip+=/var/tmp/*

" If folds exist, they were probably set manually... and explicit is always
" best!
set foldmethod=marker

" Open new windows to the right.
set splitright

" Nuke evil whitespace from orbit
function StripTrailingWhitespace()
    " Don't remove trailing whitespace for these filetypes
    if &ft =~ 'markdown\|gitsendemail\|json'
        return
    endif
    let save_cursor = getpos(".")
    " Match and remove blank lines at EOF
    :silent! %s#\($\n\s*\)\+\%$##
    " Match and remove whitespace at EOL
    :silent! %s#\s\+$##
    call setpos('.', save_cursor)
endfunction
autocmd BufWritePre * call StripTrailingWhitespace()

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Mouse isn't auto-enabled :(
if has('mouse')
  set mouse=a
endif

" PKGBUILD is a subclass of sh
let g:syntastic_filetype_map = { "PKGBUILD": "sh" }
" Syntastic shouldn't check for makepkg variables or erroring `cd`s.
if @% =~ 'PKGBUILD$' || &ft ==? 'PKGBUILD'
    let b:syntastic_sh_shellcheck_post_args = "-e SC2034,SC2154,SC2164"
endif

" vim's internal logic for editing http:// files is completely broken,
" utterly. It doesn't follow redirects.
let g:netrw_http_cmd = "curl"
let g:netrw_http_xcmd = "-fLo"

" EditorConfig globalness
let g:EditorConfig_python_files_dir = '/usr/lib/python3.6/site-packages/editorconfig'
let g:EditorConfig_core_mode = 'python_builtin'
let g:EditorConfig_max_line_indicator = "exceeding"


""" Key mappings
" up/down treats wrapped lines as separate lines
nnoremap j gj
nnoremap k gk
