local M = {}

local function is_lsp_attached()
  return next(vim.lsp.buf_get_clients(0))
end

local function get_count(buffer_number, diagnostic_type)
  if vim.diagnostic == nil then
    -- starting nvim-0.5
    local severity = ({
      hint = 'Hint',
      info = 'Information',
      warn = 'Warn',
      error = 'Error'
    })[diagnostic_type]

    return vim.lsp.diagnostic.get_count(buffer_number, severity)
  else
    -- starting nvim-0.6
    local severity = ({
      hint = vim.diagnostic.severity.HINT,
      info = vim.diagnostic.severity.INFO,
      warn = vim.diagnostic.severity.WARN,
      error = vim.diagnostic.severity.ERROR
    })[diagnostic_type]

    return vim.tbl_count(vim.diagnostic.get(
      buffer_number,
      {
        severity = severity
      }
    ))
  end
end

M._get_diagnostic_count = function (diagnostic_type)
  if not is_lsp_attached() then
    return 0
  end

  local active_clients = vim.lsp.get_active_clients()
  if vim.tbl_isempty(active_clients) then
    return 0
  end

  return get_count(vim.api.nvim_get_current_buf(), diagnostic_type)
end

return M
