-- vim: set tabstop=2 shiftwidth=2 expandtab
local M = {}

function M.setup()
    -- Indicate first time installation
    local packer_bootstrap = false

    -- packer.nvim configuration
    local conf = {
        display = {
            open_fn = function()
                return require("packer.util").float { border = "rounded" }
            end,
        },
    }

    -- Check if packer.nvim is installed
    -- Run PackerCompile if there are changes in this file
    local function packer_init()
        local fn = vim.fn
        local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
        if fn.empty(fn.glob(install_path)) > 0 then
            packer_bootstrap = fn.system {
                    "git",
                    "clone",
                    "--depth",
                    "1",
                    "https://github.com/wbthomason/packer.nvim",
                    install_path,
                }
            vim.cmd [[packadd packer.nvim]]
        end
        vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
    end

    -- start of the plugin list
    local function plugins(use)
        use { 'wbthomason/packer.nvim' }
        use { 'ray-x/go.nvim',
            config = function()
                require('go').setup()
            end }
        use { 'ishan9299/nvim-solarized-lua',
            config = function()
                vim.cmd 'colorscheme solarized'
            end, }
        use { 'tanvirtin/vgit.nvim',
            requires = { 'nvim-lua/plenary.nvim' },
            config = function()
                require('vgit').setup()
            end }
        use { 'lewis6991/gitsigns.nvim',
            requires = { 'nvim-lua/plenary.nvim' },
            config = function()
                require('gitsigns').setup()
            end }
        use { 'neovim/nvim-lspconfig' }
        use { 'williamboman/mason.nvim',
            config = function()
                require('mason').setup()
            end }
        use { 'williamboman/mason-lspconfig.nvim',
            requires = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
            config = function()
                require('mason-lspconfig').setup()
            end }
        use { 'WhoIsSethDaniel/mason-tool-installer.nvim',
            requires = { 'williamboman/mason.nvim' }
        }
        use { 'windwp/nvim-autopairs',
            config = function()
                require('nvim-autopairs').setup()
            end }
        use { 'b0o/schemastore.nvim' }
        use { 'neoclide/coc.nvim',
            branch = 'release'
        }
        use { 'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
                ts_update()
            end }


        if packer_bootstrap then
            print "Restart Neovim required after installation!"
            require('packer').sync()
        end
    end

    packer_init()

    local packer = require 'packer'
    packer.init(conf)
    packer.startup(plugins)
end

return M
