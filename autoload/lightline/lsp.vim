let s:indicator_hints = get(g:, 'lightline#lsp#indicator_hints', 'H: ')
let s:indicator_infos = get(g:, 'lightline#lsp#indicator_infos', 'I: ')
let s:indicator_warnings = get(g:, 'lightline#lsp#indicator_warnings', 'W: ')
let s:indicator_errors = get(g:, 'lightline#lsp#indicator_errors', 'E: ')
let s:indicator_ok = get(g:, 'lightline#lsp#indicator_ok', 'OK')
let s:update_in_insert = get(g:, 'lightline#lsp#update_in_insert', v:true)

if !exists('s:hint')
  let s:hint = ''
endif
if !exists('s:info')
  let s:info = ''
endif
if !exists('s:warn')
  let s:warn = ''
endif
if !exists('s:error')
  let s:error = ''
endif
if !exists('s:ok')
  let s:ok = ''
endif

""""""""""""""""""""""
" Lightline components

function! s:skip_update_in_insert() abort
  return !s:update_in_insert && mode() == 'i'
endfunction

function! lightline#lsp#hints() abort
  if !lightline#lsp#linted()
    return ''
  endif
  if s:skip_update_in_insert()
    return s:hint
  endif
  let l:counts = luaeval("require('lightline-lsp')._get_diagnostic_count('hint')")
  let s:hint = l:counts == 0 ? '' : printf(s:indicator_hints . '%d', counts)
  return s:hint
endfunction

function! lightline#lsp#infos() abort
  if !lightline#lsp#linted()
    return ''
  endif
  if s:skip_update_in_insert()
    return s:info
  endif
  let l:counts = luaeval("require('lightline-lsp')._get_diagnostic_count('info')")
  let s:info = l:counts == 0 ? '' : printf(s:indicator_infos . '%d', counts)
  return s:info
endfunction

function! lightline#lsp#warnings() abort
  if !lightline#lsp#linted()
    return ''
  endif
  if s:skip_update_in_insert()
    return s:warn
  endif
  let l:counts = luaeval("require('lightline-lsp')._get_diagnostic_count('warn')")
  let s:warn = l:counts == 0 ? '' : printf(s:indicator_warnings . '%d', counts)
  return s:warn
endfunction

function! lightline#lsp#errors() abort
  if !lightline#lsp#linted()
    return ''
  endif
  if s:skip_update_in_insert()
    return s:error
  endif
  let l:counts = luaeval("require('lightline-lsp')._get_diagnostic_count('error')")
  let s:error = l:counts == 0 ? '' : printf(s:indicator_errors . '%d', counts)
  return s:error
endfunction

function! lightline#lsp#ok() abort
  if !lightline#lsp#linted()
    return ''
  endif
  if s:skip_update_in_insert()
    return s:ok
  endif
  echom s:ok
  let l:hint_counts = luaeval("require('lightline-lsp')._get_diagnostic_count('hint')")
  let l:info_counts = luaeval("require('lightline-lsp')._get_diagnostic_count('info')")
  let l:warn_counts = luaeval("require('lightline-lsp')._get_diagnostic_count('warn')")
  let l:error_counts = luaeval("require('lightline-lsp')._get_diagnostic_count('error')")
  let l:counts = l:hint_counts+l:info_counts+l:warn_counts+l:error_counts
  let s:ok = l:counts == 0 ? s:indicator_ok : ''
  return s:ok
endfunction

""""""""""""""""""
" Helper functions

function! lightline#lsp#linted() abort
  return !!luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients('.bufnr().'))')
endfunction
