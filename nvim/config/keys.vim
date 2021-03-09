
let mapleader=","                  " set <space> to <leader>

" vimrc mappings
nnoremap <Leader>v :e $MYVIMRC<CR>
nnoremap <Leader>V :tabe $MYVIMRC<CR>
nnoremap <Leader>so :so $MYVIMRC<CR>

" Terminal mode:
tnoremap <Esc> <C-\><C-n>
tnoremap <M-[> <Esc>
tnoremap <A-h> <c-\><c-n><c-w>h
tnoremap <A-j> <c-\><c-n><c-w>j
tnoremap <A-k> <c-\><c-n><c-w>k
tnoremap <A-l> <c-\><c-n><c-w>l
" Insert mode:
inoremap <A-h> <Esc><c-w>h
inoremap <A-j> <Esc><c-w>j
inoremap <A-k> <Esc><c-w>k
inoremap <A-l> <Esc><c-w>l
inoremap jk <Esc>
inoremap kj <Esc>
" Visual mode:
vnoremap <A-h> <Esc><c-w>h
vnoremap <A-j> <Esc><c-w>j
vnoremap <A-k> <Esc><c-w>k
vnoremap <A-l> <Esc><c-w>l
" move the same way in wrapped lines as normaly
vnoremap j gj
vnoremap k gk

" Normal mode:
nnoremap <A-h> <c-w>h
nnoremap <A-j> <c-w>j
nnoremap <A-k> <c-w>k
nnoremap <A-l> <c-w>l
" move the same way in wrapped lines as normaly
nnoremap j gj
nnoremap k gk

" new window splitting key bindings "
nnoremap <Leader>- :sp<CR>
nnoremap <Leader>\| :vsp<CR>
nnoremap <Leader>t :tabnew<CR>

noremap <Leader>s "ayiw :%s/<C-r>a/
noremap <Leader>S "ayiW :%s/<C-r>a/
noremap <Leader>bs "ayiw :bufdo %s/<C-r>a/
noremap <Leader>bS "ayiW :bufdo %s/<C-r>a/
vmap <Leader>s "ay :%s/<C-r>a/
vmap <Leader>bs "ay :bufdo %s/<C-r>a/

noremap <Leader>a "ayiw :Ag <C-r>a<CR>
noremap <Leader>A "ayiW :Ag <C-r>a<CR>
vmap <Leader>a "ay :Ag <C-r>a<CR>

" buffer navigation
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>

" write file
map <C-s> :w<CR>
" quit buffer
map <C-x> :bp \| bd #<CR>

" remap only if popup manu is active
inoremap <C-j> <C-R>=pumvisible() ? "\<lt>C-N>" : "\<lt>C-j>"<CR>
inoremap <C-k> <C-R>=pumvisible() ? "\<lt>C-P>" : "\<lt>C-k>"<CR>

" switch between current and last buffer
nmap <leader>, <c-^>

nnoremap Y y$
noremap <2-LeftMouse> yiw

" copy current buffer path and file name into clipboard
nmap <leader>yp :let @+ = expand('%:p:h')<CR>
nmap <leader>yf :let @+ = expand('%:t')<CR>


"todo: win specific. do i need it for unix?
" windows specific shell commands
if has('win32') || has('win64')
   " ce is an alias for conemu
   nnoremap <Leader>cmd :silent !start cmd /C ce.bat<CR>
   " open expolorer for path pwd
   nnoremap <Leader>ex :silent !start cmd /C start .<CR>
endif
