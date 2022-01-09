let s:indicator_hints = get(g:, 'lightline#lsp#indicator_hints', 'H: ')
let s:indicator_infos = get(g:, 'lightline#lsp#indicator_infos', 'I: ')
let s:indicator_warnings = get(g:, 'lightline#lsp#indicator_warnings', 'W: ')
let s:indicator_errors = get(g:, 'lightline#lsp#indicator_errors', 'E: ')
let s:indicator_ok = get(g:, 'lightline#lsp#indicator_ok', 'OK')


""""""""""""""""""""""
" Lightline components

function! lightline#lsp#hints() abort
  if !lightline#lsp#linted()
    return ''
  endif
  let l:counts = luaeval("require('lightline-lsp')._get_diagnostic_count('hint')")
  return l:counts == 0 ? '' : printf(s:indicator_hints . '%d', counts)
endfunction

function! lightline#lsp#infos() abort
  if !lightline#lsp#linted()
    return ''
  endif
  let l:counts = luaeval("require('lightline-lsp')._get_diagnostic_count('info')")
  return l:counts == 0 ? '' : printf(s:indicator_infos . '%d', counts)
endfunction

function! lightline#lsp#warnings() abort
  if !lightline#lsp#linted()
    return ''
  endif
  let l:counts = luaeval("require('lightline-lsp')._get_diagnostic_count('warn')")
  return l:counts == 0 ? '' : printf(s:indicator_warnings . '%d', counts)
endfunction

function! lightline#lsp#errors() abort
  if !lightline#lsp#linted()
    return ''
  endif
  let l:counts = luaeval("require('lightline-lsp')._get_diagnostic_count('error')")
  return l:counts == 0 ? '' : printf(s:indicator_errors . '%d', counts)
endfunction

function! lightline#lsp#ok() abort
  if !lightline#lsp#linted()
    return ''
  endif
  let l:hint_counts = luaeval("require('lightline-lsp')._get_diagnostic_count('hint')")
  let l:info_counts = luaeval("require('lightline-lsp')._get_diagnostic_count('info')")
  let l:warn_counts = luaeval("require('lightline-lsp')._get_diagnostic_count('warn')")
  let l:error_counts = luaeval("require('lightline-lsp')._get_diagnostic_count('error')")
  let l:counts = l:hint_counts+l:info_counts+l:warn_counts+l:error_counts
  return l:counts == 0 ? s:indicator_ok : ''
endfunction

""""""""""""""""""
" Helper functions

function! lightline#lsp#linted() abort
  return !!luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients('.bufnr().'))')
endfunction
