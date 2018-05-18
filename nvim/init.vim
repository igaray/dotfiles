" PLUG
call plug#begin('~/.config/nvim/plugged')
 Plug 'https://github.com/altercation/vim-colors-solarized.git'
 Plug 'https://github.com/scrooloose/nerdtree.git'
 Plug 'https://github.com/airblade/vim-gitgutter.git'
 Plug 'https://github.com/jnurmine/Zenburn.git'
 Plug 'https://github.com/tpope/vim-unimpaired.git'
 Plug 'https://github.com/tpope/vim-fugitive.git'
 Plug 'https://github.com/tpope/vim-markdown.git'
 Plug 'https://github.com/terryma/vim-multiple-cursors.git'
"Plug 'https://github.com/wincent/command-t.git'
"Plug 'https://github.com/itchyny/lightline.vim.git'
"Plug 'https://github.com/Valloric/YouCompleteMe.git'
call plug#end()

" APPEARANCE
"colorscheme zenburn
 set number
 set colorcolumn=80,100
 set list
 set listchars=tab:▸\ ,eol:¶

" SPACES AND INDENT
 set tabstop=2
 set softtabstop=2
 set shiftwidth=2
 set expandtab
 set autoindent
 set smartindent
 set smarttab

" LINE NUMBERS
set relativenumber
set number

" FOLDING
 set foldenable
 set foldmethod=syntax

" LEADER
 let mapleader=" "

" SEARCH
 set hlsearch
 nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

" C SETUP
"augroup project
"    autocmd!
"    autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
"augroup END
"autocmd FileType c nnoremap <buffer> <silent> <C-]> :YcmCompleter GoTo<cr>
"let g:ycm_extra_conf_globlist = ['~/Projects/*']
"let g:ycm_confirm_extra_conf = 0
"let g:ycm_global_ycm_extra_conf = '/home/igaray/.ycm_extra_conf.py'

" AUTOCOMMANDS
 autocmd BufWritePre * :%s/\s\+$//e

" NERDTREE
 let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp']
 map <leader>s :source ~/.config/nvim/init.vim<CR>
 nmap <leader>n :NERDTreeToggle<CR>
 nmap <leader>j :NERDTreeFind<CR>

