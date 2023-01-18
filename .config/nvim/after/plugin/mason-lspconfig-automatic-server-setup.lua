-- see :h mason-lspconfig-automatic-server-setup
require('mason-lspconfig').setup_handlers {
    function (server_name)
        require('lspconfig')[server_name].setup {}
    end,
}
