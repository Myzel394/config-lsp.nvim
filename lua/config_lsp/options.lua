--- Options
--- Type definitions
---@class Options
---@field executable OptionsExecutable
---@field inject_lsp boolean - Whether to inject the LSP config into nvim-lspconfig or native LSP. Default: `true`
---@field add_filetypes boolean - Whether to add our own custom config filetypes. Default: `true`
---
---@class OptionsExecutable
---@field path string - Path to the config-lsp executable. If not set, config-lsp.nvim will try to find it in the system PATH, or download it automatically.
---@field args string[] - Arguments to pass to the executable - If you want to disable telemetry, add `--usage-reports-errors-only` or `--usage-reports-disable` here. Default: `{"--no-undetectable-errors"}`
---@field download_folder string - Folder to download the executable to, if not found in PATH; Defaults to `stdpath("data") .. "/config-lsp/bin"`

local DEFAULT_OPTIONS = {
  executable = {
    path = nil,
    args = {
      "--no-undetectable-errors",
    },
    download_folder = vim.fn.stdpath("data") .. "/config-lsp/bin",
  },
  inject_lsp = true,
  add_filetypes = true,
}


return {
  DEFAULT_OPTIONS = DEFAULT_OPTIONS,
}
