# config-lsp.nvim

Official Neovim plugin for [config-lsp](https://github.com/Myzel394/config-lsp).

> A language server for configuration files. The goal is to make editing config files modern and easy.

## Usage

If you set `add_filetypes` to true, config-lsp.nvim will automatically add the filetypes that config-lsp knows about to Neovim. 
If you also set `inject_lsp` to true, config-lsp.nvim will automatically set up the lspconfig server for config-lsp.
This means that when you open a config file, Neovim will automatically detect the filetype and use config-lsp for it.

## Installation

Install using your favorite plugin manager. For example, using `lazy.nvim`:

```lua
{
    "https://git.myzel394.app/Myzel394/config-lsp.nvim",
    opts = {
        -- Everything related to the executable
        -- You can let config-lsp.nvim automatically download
        -- the config-lsp executable for you, or provide your own path.
        --
        -- config-lsp.nvim will try to find config-lsp in the following order:
        -- 1. If `path` is not nil, try `path`
        -- 2. Try simply calling `config-lsp` (you'll need to add `config-lsp` to your `$PATH` for that to work)
        -- 3. Try the `config-lsp` binary inside the specified `executable.download_folder`
        -- 4. If `config-lsp` is still not found, config-lsp.nvim will automatically download the latest release
        --    and place it inside your `executable.download_folder`
        executable = {
            -- The path to look for `config-lsp`
            path = nil,
            -- What args to pass to `config-lsp`
            -- See https://github.com/Myzel394/config-lsp#configuration for available args
            args = {
                "--no-undetectable-errors",
            },
            -- Where to download the `config-lsp` binary if it's not found
            download_folder = vim.fn.stdpath("data") .. "/config-lsp/bin",
        },
        -- If true, config-lsp.nvim will automatically set up the lspconfig server for you
        inject_lsp = true,
        -- If true, config-lsp.nvim will add the filetypes it knows about to neovim
        add_filetypes = true,
    },
}
```

## Supporting config-lsp.nvim development

If you want to support the development of config-lsp.nvim, consider [sponsoring me via GitHub](https://github.com/sponsors/Myzel394), or [donating via cryptocurrencies](https://github.com/Myzel394/contact-me?tab=readme-ov-file#donations).

Oh and spreading the word about config-lsp is also a great way to support the project :)

