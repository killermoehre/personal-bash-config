require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "bash",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "help",
        "lua",
        "markdown",
        "python",
        "yaml",
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
