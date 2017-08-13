" Plugins "
"""""""""""

set runtimepath^=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" call dein#install() to install
call dein#begin(expand('~/.cache/dein'))

call dein#add('Shougo/dein.vim')

call dein#add('Shougo/context_filetype.vim')
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/neoinclude.vim')
call dein#add('Shougo/neopairs.vim')
call dein#add('cespare/vim-toml')
call dein#add('dhruvasagar/vim-table-mode')
call dein#add('kien/ctrlp.vim')
call dein#add('majutsushi/tagbar')
call dein#add('nanotech/jellybeans.vim')
call dein#add('racer-rust/vim-racer')
call dein#add('scrooloose/nerdcommenter')
call dein#add('scrooloose/nerdtree')
call dein#add('scrooloose/syntastic')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('tpope/vim-fugitive')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('wting/rust.vim')

call dein#end()

filetype plugin indent on


" Plugin Settings "
"""""""""""""""""""

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_section_z = '%3p%% %#__accent_bold#%{g:airline_symbols.linenr}'
            \ . '%#__accent_bold#%4l%#__restore__#%#__restore__#/%L:%3v'
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline#extensions#whitespace#checks = ['indent', 'long', 'trailing',
            \ 'mixed-indent-file']

" deoplete
let g:deoplete#enable_at_startup = 1

inoremap <silent> <CR> <C-r>=<SID>cr_func()<CR>
fu! s:cr_func() abort
    return deoplete#mappings#close_popup() . "\<CR>"
endf

inoremap <silent> <expr> <tab> pumvisible() ? "\<C-n>" : "\<tab>"

if !exists('g:doeplete#sources#omni#input_patterns')
    let g:deoplete#sources#omni#input_patterns = {}
endif
let g:deoplete#sources#omni#input_patterns.rust = '[^.[:digit:] *\t]\%(\.\|\::\)\%(\h\w*\)\?'

" Vim multiple cursors
fu! MultipleCursorsBefore()
    let g:deoplete_disable_auto_complete = 1
endf

fu! MultipleCursorsAfter()
    let g:deoplete_disable_auto_complete = 0
endf

" Neopairs
let g:neopairs#enable = 1


" Autocommands "
""""""""""""""""

au BufNewFile,BufRead *.clw setf clarion

au BufWritePre * let &backupext = '.' . strftime("%Y%m%d_%H%M%S")

au BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

au InsertEnter * :set norelativenumber
au InsertLeave * :set relativenumber


" General Settings "
""""""""""""""""""""

set guifont="Bitstream Vera Sans Mono for Powerline 9" "deprecated?
set hidden
set ignorecase
set listchars=tab:»\ ,trail:·
set list
set number
set relativenumber
set showcmd
set smartcase
set smartindent
set spelllang=en_gb

set backup
set swapfile
set undofile

silent !mkdir -p $HOME/.cache/nvim/{backup,undo,swap} >/dev/null 2>&1
set backupdir=$HOME/.cache/nvim/backup
set directory=$HOME/.cache/nvim/swap
set undodir=$HOME/.cache/nvim/undo


" Visual elements "
"""""""""""""""""""

if &t_Co > 2 || has("gui_running")
    syntax on
    if &t_Co == 256 || has("gui_running")
        color jellybeans
    else
        color delek
    endif
endif

highlight ColorColumn2 ctermbg=red
highlight ColorColumn ctermbg=black
call matchadd('ColorColumn', '\%81v', 100)
call matchadd('ColorColumn2', '\%91v', 100)


" Key Mappings "
""""""""""""""""

" Set leader
let mapleader = ","
let g:mapleader = ","

" Spell check
nnoremap <silent> <leader>s :setlocal spell!<CR>

" Navigation
nnoremap <silent> <F7> :bprev<CR>
nnoremap <silent> <A-h> :bprev<CR>
nnoremap <silent> <F8> :bnext<CR>
nnoremap <silent> <A-l> :next<CR>

tnoremap <A-space> <C-\><C-n>

nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Terminal
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

" Make and errors
nnoremap <silent> <F5> :make<CR>
nnoremap <silent> <F6> :cw<CR>

" Set filetype
nnoremap <leader>ff :set ft=

" Clear highlighting
nnoremap <silent> <F3> :nohlsearch<CR>

" Tab key virtualedit
fu! ToggleVirtual()
    if &virtualedit == "all"
        set virtualedit=
    else
        set virtualedit=all
    endif
endf

nnoremap <silent> <tab> :call ToggleVirtual()<CR>

" Remove trailing whitespace
fu! RemoveTrailing()
    let line_num = line('.')
    exe '%s/\s*$//'
    exe 'normal! ' . line_num . 'G'
endf

nnoremap <silent> <leader>rw :call RemoveTrailing()<cr>

" Sort range
vnoremap <silent> <leader>s :sort<CR>

" sprunge
nnoremap <leader>P :w !curl -F "sprunge=<-" http://sprunge.us<CR>
vnoremap <leader>P :w !curl -F "sprunge=<-" http://sprunge.us<CR>
