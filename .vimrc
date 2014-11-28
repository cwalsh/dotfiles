set smartindent
set expandtab
set softtabstop=2
set shiftwidth=2
set pastetoggle=<F2>
set laststatus=2
noremap <F6> :bnext!<CR>
noremap <F5> :bprev!<CR>
inoremap <F6> :bnext!<CR>
inoremap <F5> :bprev!<CR>

call pathogen#infect()
syntax on
filetype on
au BufNewFile,BufRead,BufWrite *.dump set filetype=sql
au BufNewFile,BufRead,BufWrite Vagrantfile,Gemfile,Gemfile.lock,config.ru,*.rabl,*.pp set filetype=ruby
au BufNewFile,BufRead,BufWrite *.yml set filetype=yaml
au BufNewFile,BufRead,BufWrite composer.lock set filetype=json
au BufNewFile,BufRead,BufWrite *.twig set filetype=php
autocmd FileType json,sh,spec,c,cpp,python,ruby,java,yaml,javascript,html,css,coffee,haml,php autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd FileType php set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4

map <leader>h              :wincmd h<cr>
map <leader>j              :wincmd j<cr>
map <leader>k              :wincmd k<cr>
map <leader>l              :wincmd l<cr>

set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor
