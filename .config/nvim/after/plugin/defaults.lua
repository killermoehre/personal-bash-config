local api = vim.api
local g = vim.g
local opt = vim.opt
local cmd = vim.cmd
local fn = vim.fn

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

opt.backup = false -- bad with some Coc servers
opt.breakindent = true --Enable break indent
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.expandtab = true
opt.hlsearch = true --Set highlight on search
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.laststatus = 2
opt.modeline = true
opt.mouse = "a" --Enable mouse mode
opt.number = true --Make line numbers default
opt.relativenumber = false --Make relative number default
opt.shiftwidth = 4
opt.showmode = true
opt.showtabline = 2
opt.signcolumn = "yes" -- Always show sign column
opt.smartcase = true -- Smart case
opt.smartindent = true
opt.smarttab = true
opt.tabstop = 4
opt.termguicolors = true -- Enable colors in terminal
opt.undofile = true --Save undo history
opt.updatetime = 250 --Decrease update time
opt.writebackup = false -- bad with seom Coc servers

-- Highlight on yank
cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

cmd [[
  autocmd BufWritePre * lua vim.lsp.buf.format()
]]


local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = fn.col('.') - 1
    return col == 0 or fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
