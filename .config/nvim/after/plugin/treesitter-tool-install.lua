require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "bash",
        "comment",
        "diff",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "help",
        "jq",
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
