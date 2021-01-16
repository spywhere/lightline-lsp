augroup lightline#lsp
  autocmd!
  autocmd User LspDiagnosticsChanged call lightline#update()
augroup END
