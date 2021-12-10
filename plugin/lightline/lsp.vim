if has('nvim-0.6')
  augroup lightline#lsp
    autocmd!
    autocmd DiagnosticChanged * call lightline#update()
  augroup END
else
  augroup lightline#lsp
    autocmd!
    autocmd User LspDiagnosticsChanged call lightline#update()
  augroup END
endif
