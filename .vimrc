set autoindent
set expandtab
set softtabstop=2
set shiftwidth=2
set pastetoggle=<F2>
noremap <F6> :bnext!<CR>
noremap <F5> :bprev!<CR>
inoremap <F6> :bnext!<CR>
inoremap <F5> :bprev!<CR>
noremap <F8> :tabnext<CR>
noremap <F7> :tabprev!<CR>
inoremap <F8> :tabnext!<CR>
inoremap <F7> :tabprev!<CR>

call pathogen#infect()
syntax on
filetype on
au BufNewFile,BufRead,BufWrite *.dump set filetype=sql
au BufNewFile,BufRead,BufWrite Gemfile,Gemfile.lock,config.ru,*.rabl set filetype=ruby
autocmd FileType sh,spec,c,cpp,python,ruby,java autocmd BufWritePre <buffer> :%s/\s\+$//e
