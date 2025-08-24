local utils = require("config_lsp.utils")
local executable = require("config_lsp.executable")
local options = require("config_lsp.options")
local lsp = require("config_lsp.lsp")

local global_executable_path = nil

--- Setup function
--- @param opts Options
local function setup(opts)
  ---@type Options
  local final_opts = utils.merge_tables(options.DEFAULT_OPTIONS, opts or {})

  if final_opts.add_filetypes then
    lsp.add_filetypes()
  end

  global_executable_path = executable.prepare_executable(final_opts)

  if global_executable_path == nil then
    return
  end

  if final_opts.inject_lsp then
    lsp.setup_config_lsp(global_executable_path, final_opts.executable.args)
  end
end

--- Get the path to the config-lsp executable being used
--- @return string|nil - Path to executable, or nil if not set up yet / or executable not found
local function get_executable_path()
  return global_executable_path
end

return {
  setup = setup,
  get_executable_path = get_executable_path,
}
