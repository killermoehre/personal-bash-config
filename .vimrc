" enable plugins
call plug#begin('~/.vim/bundle')
Plug 'tpope/vim-git'
Plug 'airblade/vim-gitgutter'
Plug 'wincent/Terminus'
Plug 'plytophogy/vim-virtualenv'
Plug 'powerline/powerline'
Plug 'altercation/vim-colors-solarized'
Plug 'cespare/vim-toml'
Plug 'towolf/vim-helm'
Plug 'integralist/vim-mypy'
Plug 'dense-analysis/ale'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'rhysd/vim-lsp-ale'
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

" always show gutter-line (remove pop-in-pop-out flicker)
let g:ale_sign_column_always = 1

" lint after 1000ms after changes are made both on insert mode and normal mode
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 1000

" use nice symbols for errors and warnings
let g:ale_sign_error = '✗ '
let g:ale_sign_warning = '⚠ '

" === ale-lsp-bridge ===
" enable LSP as auto-linter in ALE
let g:lsp_ale_auto_enable_lint = v:true
