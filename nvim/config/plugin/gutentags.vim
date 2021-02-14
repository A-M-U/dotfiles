call minpac#add('ludovicchabant/vim-gutentags')



" - ctags uses a config file (~\.ctags).
" - It is possible to exclude directories from being tagged. (--exclude=dirname)
" - generate tags for includes (--extra=+f)
" set tags=./tags,tags;
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" g<C-]> opens a list with all matched tags if multiple are available.
" If only one is available it goes directly to the tag.
" map <C-]> g<C-]>

" nmap <leader>.ct :e ~/.ctags<CR>


" set statusline+=%{gutentags#statusline()}

" custom project root identifier
let g:gutentags_project_root = ['Makefile']

" save tags in separate dir
let g:gutentags_cache_dir = $vim_data_dir."/tags"

