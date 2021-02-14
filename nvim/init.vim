let s:is_win = has('win32') || has('win64')
let $vim_config_dir = stdpath('config') 
let $vim_data_dir = stdpath('data')

if empty(glob('$vim_config_dir/pack/minpac/opt/minpac')) 	
  execute '!git clone https://github.com/k-takata/minpac.git '$vim_config_dir.'/pack/minpac/opt/minpac'
  autocmd VimEnter * call minpac#update() | source $MYVIMRC
endif

packadd minpac
call minpac#init()
" minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
call minpac#add('k-takata/minpac', {'type': 'opt'})

" plugins without configuration
call minpac#add('rakr/vim-one')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('nelstrom/vim-visual-star-search')
if s:is_win == 0
    call minpac#add('edkolev/tmuxline.vim')
endif

call minpac#add('junegunn/gv.vim')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-surround')

" plugins with configuration
source $vim_config_dir/config/plugin/airline.vim
source $vim_config_dir/config/plugin/fugitive.vim
source $vim_config_dir/config/plugin/fzf.vim
source $vim_config_dir/config/plugin/gutentags.vim
source $vim_config_dir/config/plugin/indentline.vim
source $vim_config_dir/config/plugin/nerdtree.vim
source $vim_config_dir/config/plugin/neoterm.vim
source $vim_config_dir/config/plugin/signify.vim
source $vim_config_dir/config/plugin/sneak.vim
source $vim_config_dir/config/plugin/tabular.vim
source $vim_config_dir/config/plugin/tagbar.vim

" auto completion
if exists('g:vscode')
    source $vim_config_dir/config/plugin/vscode.vim
else
    if s:is_win == 0
        source $vim_config_dir/config/plugin/coc.vim
    else
        call minpac#add('machakann/vim-highlightedyank')
        source $vim_config_dir/config/plugin/deoplete.vim
        source $vim_config_dir/config/plugin/ultisnips.vim
    endif
endif

source $vim_config_dir/config/commands.vim
source $vim_config_dir/config/keys.vim
source $vim_config_dir/config/settings.vim

if exists('g:started_by_firenvim')
    source $vim_config_dir/config/plugin/firenvim.vim
else
    source $vim_config_dir/config/plugin/startify.vim
endif

let s:local_vimrc = $vim_config_dir.'/local.vim'
if filereadable(s:local_vimrc)
  execute 'source' s:local_vimrc
endif

" vim:foldmethod=marker:foldlevel=0
