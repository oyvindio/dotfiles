" .vimrc

set nocompatible                 " Disable VI compatibility mode
set ruler                       " Always show cursor position
set showcmd                     " show partial command in status line
set showmode                    " show whether in insert, visual mode etc
set background=dark             " dark background
set number                      " enable line numbers
set showmatch                   " indicate matching parentheses, braces etc

" Character encoding
set encoding=utf-8
set termencoding=utf-8

" Syntax highlighting
syntax on
filetype plugin indent on
colorscheme gardener
set t_Co=256                    " tell vim that the terminal we're using
                                " supports 256 colors (may not be the case!)

" Set correct colorscheme (kinda works, kinda doesn't)
"if has('gui_running')
"    colorscheme gardener
"elseif (&term =~ '256color$')
"    colorscheme gardener
"else
"    colorscheme evening
"endif

" Disable vbell
set vb
set t_vb=

"Save backups of buffers in .vim/backup
set autowrite
set writebackup
set backup backupdir=$HOME/.vim/backup

" Search
set hlsearch                    " Highlight matches
set incsearch                   " Enable incremental search
set ignorecase                  " Ignore case when searching
set smartcase                   " Enable 'intelligent' case detection

" History
set history=1000                " Remember 1000 commands
set undolevels=500              " Let me undo the past 500 actions

" Indentation
set expandtab                   " Use spaces, not tab characters
"set smarttab                    " Enable 'intelligent' indentation
set autoindent                  " Autoindent 'intelligently'
set tabstop=4                   " Show tab characters as 4 spaces
set softtabstop=4               " Show tab characters as 4 spaces
set shiftwidth=4                " Number of spaces to (auto)indent

" Tab completion in the command line
set wildmenu                    " Enable command line tab completion
"set wildmode=longest:full,full  " Command line tab completion behavior
set wildmode=list:longest,full  " Command line tab completion behavior
set wildchar=<Tab>              " <tab> selects what to complete

" Set the default clipboard buffer to + - the X clipboard
let g:clipbrdDefaultReg = '+'

"key bindings
set pastetoggle=<f5>
noremap <silent> <f1> :Tlist<cr>
noremap <silent> <f2> :set list!<cr>
noremap <silent> <f3> :make<cr>
noremap <silent> <f4> :nohlsearch<cr>
noremap! <silent> <f1> <c-o>:Tlist<cr>
noremap! <silent> <f2> <c-o>:set list!<cr>
noremap! <silent> <f3> <c-o>:make<cr>
noremap! <silent> <f4> :<c-o>nohlsearch<cr>
":noremap Q @q

map <c-t> :NERDTreeToggle<CR>
map <c-s> :Scratch<CR>

