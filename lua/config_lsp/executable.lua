-- Everything related to the 'config-lsp' executable
local utils = require("config_lsp.utils")
local options = require("config_lsp.options")
local constants = require("config_lsp.constants")

---@param path string
---@return boolean - Whether the executable at `path` is valid
local function try_executable(path)
  -- Try running `path --version` to see if it's a valid executable
  local result = vim.api.nvim_command("silent !\"" .. path .. "\" --version")
  return result == nil
end

--- @param opts Options
--- @return string|nil - Output path
local function download_executable(opts)
  ---@type string
  local output_folder
  if opts.executable.download_folder ~= nil then
    output_folder = opts.executable.download_folder
  else
    output_folder = vim.fn.stdpath("data") .. "/config-lsp"
  end

  local output_path = output_folder .. "/config-lsp"

  -- Check if already exists
  if try_executable(output_path) == true then
    return output_path
  end

  local os_name = vim.loop.os_uname().sysname
  local architecture = vim.loop.os_uname().machine

  local url = "https://github.com/Myzel394/config-lsp/releases/download/" .. constants.LAST_VERSION .. "/config-lsp_" .. os_name .. "_" .. architecture .. ".tar.gz"
  local temp_path = vim.fn.tempname() .. ".tar.gz"

  -- Download

  local download_cmd = string.format("curl --silent --show-error -L -o %s %s", temp_path, url)
  local result = vim.fn.system(download_cmd)

  if vim.v.shell_error ~= 0 then
    vim.notify("[config-lsp] Failed to download 'config-lsp' executable: " .. result, vim.log.levels.ERROR)
    return nil
  end

  -- Unzip

  vim.fn.mkdir(output_folder, "p")
  local unzip_cmd = string.format("tar -xzf %s -C %s", temp_path, output_folder)

  result = vim.fn.system(unzip_cmd)

  if vim.v.shell_error ~= 0 then
    vim.notify("[config-lsp] Failed to unzip 'config-lsp' executable: " .. result, vim.log.levels.ERROR)
    return nil
  end

  -- Make the file executable
  vim.fn.system("chmod +x " .. output_path)

  if vim.v.shell_error ~= 0 then
    vim.notify("[config-lsp] Failed to make 'config-lsp' executable: " .. result, vim.log.levels.ERROR)
    return nil
  end

  return output_path
end

--- @param opts Options
--- @return string|nil - Path to executable
local function prepare_executable(opts)
  ---@type string|nil
  local executable_path

  -- Try specified path
  if opts.executable.path ~= nil and try_executable(opts.executable.path) then
    executable_path = opts.executable.path
  end

  -- Try system PATH
  if executable_path == nil then
    local system_path = vim.fn.exepath("config-lsp")
    if system_path ~= "" and try_executable(system_path) then
      executable_path = system_path
    end
  end

  if executable_path == nil then
    vim.notify(
      "[config-lsp] Could not find 'config-lsp' executable. I will download it now for you...",
      vim.log.levels.INFO
    )

    executable_path = download_executable(opts)

    if executable_path == nil or not try_executable(executable_path) then
      return
    end

    vim.notify("[config-lsp] Successfully downloaded 'config-lsp' executable to " .. executable_path, vim.log.levels.INFO)
  end

  return executable_path
end

return {
  prepare_executable = prepare_executable,
}
