local fn = vim.fn
local luv = vim.loop
local vim_plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
local config_path = fn.stdpath('config')
local working_dir = fn.getcwd()
local vim_plug_path = config_path .. '/autoload/plug.vim'
local plugin_home = working_dir .. '/tests/plugged'

if fn.filereadable(vim_plug_path) == 0 then
  vim.cmd(
    'silent !curl -fLo ' .. vim_plug_path .. ' --create-dirs ' .. vim_plug_url
  )
end

fn['plug#begin'](plugin_home)

fn['plug#']('itchyny/lightline.vim')
fn['plug#'](working_dir)
fn['plug#']('neovim/nvim-lspconfig')

local lightline = {
  component_expand = {
    linter_hints = 'lightline#lsp#hints',
    linter_infos = 'lightline#lsp#infos',
    linter_warnings = 'lightline#lsp#warnings',
    linter_errors = 'lightline#lsp#errors',
    linter_ok = 'lightline#lsp#ok',
  },
  component_type = {
    linter_hints = 'right',
    linter_infos = 'right',
    linter_warnings = 'warning',
    linter_errors = 'error',
    linter_ok = 'tabsel',
  },
  active = {
    right = {
      {
        'linter_ok',
        'linter_errors',
        'linter_warnings',
        'linter_infos',
        'linter_hints'
      }
    }
  }
}
vim.g.lightline = lightline

fn['plug#end']()

local is_plugin_missing = function (plugin)
  local stat = luv.fs_stat(plugin.dir)
  if not stat or stat.type ~= 'directory' then
    return true
  end
  return false
end

local plugins = vim.tbl_values(vim.g.plugs)
local missing_plugins = vim.tbl_filter(is_plugin_missing, plugins)
if next(missing_plugins) then
  vim.cmd('PlugInstall --sync | q')
end

require('lspconfig').tsserver.setup{}
