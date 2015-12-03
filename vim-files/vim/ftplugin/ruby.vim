" Neomake
let g:neomake_ruby_enabled_makers = ['rubocop']
let g:neomake_ruby_rubocop_maker = {
  \ 'args': ['--except', 'Style/TrailingComma,Style/Documentation,Metrics/ClassLength,Metrics/ModuleLength,Metrics/MethodLength,Style/SignalException'],
  \}

" vim-rspec mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>
