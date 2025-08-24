---@param path string
---@param args string[] - Arguments to pass to the executable
local function setup_config_lsp(path, args)
  -- Get current neovim version
  local nvim_version = vim.version()

  if nvim_version.minor < 11 then
    vim.notify(
      "[config-lsp] LSP injection requires Neovim 0.11 or higher. Please upgrade your Neovim version or install config-lsp manually.",
      vim.log.levels.WARN
    )
  end

  -- LSP config
  vim.lsp.config["config_lsp"] = {
      cmd = {
        path,
        unpack(args or {})
      },
      filetypes = {
          "python",
          "sshconfig",
          "sshdconfig",
          "fstab",
          "aliases",
          "wireguard",
          "bitcoin_conf",
          "conf"
      },
      root_dir = vim.loop.cwd,
  }
  vim.lsp.enable("config_lsp")
end

local function add_filetypes()
  -- Add custom filetypes
  vim.filetype.add({
      pattern = {
        ["*/wg%d.conf"] = "wireguard",
      },
      extension = {
          wg = "wireguard",
      },
      filename = {
          sshconfig = "sshconfig",
          sshd_config = "sshdconfig",
          fstab = "fstab",
          ["bitcoin.conf"] = "bitcoin_conf",
          ["bit.conf"] = "bitcoin_conf",
          ["bitcoind.conf"] = "bitcoin_conf",
          ["bitcoin-qt.conf"] = "bitcoin_conf",
      },
  })
end

return {
  setup_config_lsp = setup_config_lsp,
  add_filetypes = add_filetypes,
}
