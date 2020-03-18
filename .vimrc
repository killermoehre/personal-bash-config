" enable plugins
call plug#begin('~/.vim/bundle')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'airblade/vim-gitgutter'
Plug 'wincent/Terminus'
Plug 'plytophogy/vim-virtualenv'
Plug 'w0rp/ale'
Plug 'pearofducks/ansible-vim', { 'do': 'cd ./UltiSnips; VIRTUAL_ENV=/usr/local/Cellar/ansible/2.7.10/libexec /usr/local/Cellar/ansible/2.7.10/libexec/bin/python ./generate.py' }
Plug 'powerline/powerline'
Plug 'altercation/vim-colors-solarized'
call plug#end()

set backup
set backupcopy=yes
set backspace=indent,eol,start
syntax on
set background=dark
colorscheme solarized

if has("gui_running")
    set number
    if has("gui_gtk2") || has("gui_gtk3")
        set guifont=xos4\ Terminus\ 10
    elseif has("gui_macvim")
        set guifont=TerminusTTF:h16
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif
endif

set laststatus=2
set showtabline=2
set noshowmode

set modeline
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent

vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

" auto insert closing bracket
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" open quickfix window when compiler found something
au QuickFixCmdPost [^l]* nested cwindow
au QuickFixCmdPost    l* nested lwindow

" === ale ===
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'sh': ['shfmt'],
\   'xml': ['xmllint'],
\}
" always show gutter-line (remove pop-in-pop-out flicker)
let g:ale_sign_column_always = 1

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:ale_sh_shfmt_options = '-i 4'

" lint after 1000ms after changes are made both on insert mode and normal mode
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 1000

" use nice symbols for errors and warnings
let g:ale_sign_error = '✗ '
let g:ale_sign_warning = '⚠ '
