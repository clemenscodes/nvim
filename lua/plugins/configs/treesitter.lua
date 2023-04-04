local options = {
    ensure_installed = { "lua", "tsx", "json", "jsx", "html", "css", "jsx", "yaml" },
    highlight = {
        enable = true,
        use_languagetree = true,
    },
    indent = {
        enable = true,
    },
    autotag = {
        filetypes = {
            "html",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "tsx",
            "jsx",
            "css",
            "lua",
            "xml",
            "markdown",
        },
        enable = true,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
}

return options
