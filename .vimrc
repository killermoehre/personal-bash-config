" enable plugins
call plug#begin('~/.vim/bundle')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'airblade/vim-gitgutter'
Plug 'wincent/Terminus'
Plug 'plytophogy/vim-virtualenv'
Plug 'w0rp/ale'
Plug 'powerline/powerline'
Plug 'altercation/vim-colors-solarized'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dhruvasagar/vim-table-mode'
Plug 'cespare/vim-toml'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'towolf/vim-helm'
Plug 'integralist/vim-mypy'
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

" === nerdTREE ===
autocmd vimenter * NERDTree

" enable pymode; see :help pymode.txt
let g:pymode = 1
let g:pymode_python = 'python3'
let g:pymode_trim_whitespace = 1
let g:pymode_options_max_line_length = 176
let g:pymode_options_colorcolumn = 1
let g:pymode_indent = 1
let g:pymode_virtualenv = 1
let g:pymode_run = 1
let g:pymode_lint = 1
let g:pymode_lint_on_write = 1
let g:pymode_lint_on_fly = 1
let g:pymode_lint_message = 1
let g:pymode_lint_signs = 1
let g:pymode_lint_todo_symbol = '🔜'
let g:pymode_lint_comment_symbol = '💭 '
let g:pymode_lint_visual_symbol = '👀 '
let g:pymode_lint_error_symbol = '⚠️ '
let g:pymode_lint_info_symbol = 'ℹ️ '
let g:pymode_lint_pyflakes_symbol = '❄︎ '
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_ot = 1
let g:pymode_rope_completion_bind = '<C-Tab>'
let g:pymode_syntax = 1
let g:pymode_syntax_slow_sync = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_syntax_string_formatting = g:pymode_syntax_all
let g:pymode_syntax_string_format = g:pymode_syntax_all
let g:pymode_syntax_string_templates = g:pymode_syntax_all
let g:pymode_syntax_doctests = g:pymode_syntax_all
let g:pymode_syntax_builtin_types = g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions = g:pymode_syntax_all
let g:pymode_syntax_docstrings = g:pymode_syntax_all
