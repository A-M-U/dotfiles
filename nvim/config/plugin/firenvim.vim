call minpac#add('glacambre/firenvim', { 'type': 'opt', 'do': 'packadd firenvim | call firenvim#install(0)'})

let g:firenvim_config = { 
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'always',
        \ },
    \ }
\ }
let fc = g:firenvim_config['localSettings']
let fc['.*'] = { 'takeover': 'never' }

autocmd InsertLeave * :w

set autoindent&                " automatic indentation in non-C files
set smartindent&
set cindent&                   " recommended seting for automatic C-style indentation
set textwidth&      "textwidth used for reformatting lines with gq
set colorcolumn&
let g:airline#extensions#tabline#enabled = 0
set spell
set spelllang=en_us
set background=light

startinsert 
