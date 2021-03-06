
" Installed plugins and extensions:
" Pathogen
" vim-fugitive
" vim-markdown
" vim-surround
" snipmate
" vimerl
" soywiki
" solarized
" camel case completion
" erlang completion
" zencoding
" matchit

 call pathogen#infect()
 call pathogen#helptags()

 set nocompatible                                                               " Use vim settings instead of vi settings.

" Autoload
 filetype plugin indent on                                                      " Enable filetype detection
 autocmd BufReadPost *.pl set syntax=prolog

 syntax enable                  " Enable syntax highlighting.
 set background=dark
"colorscheme solarized          " Load colorscheme.
"colorscheme molokai
 if !has("gui_runnin")
     set term=screen-256color
 endif

" NetBeans-style highlight of the word under the cursor, can be slow on large files.
"autocmd CursorMoved * silent! exe printf('match IncSearch /\<%s\>/', expand('<cword>'))

" Miscelaneous
 set backspace=indent,eol,start " Make backspace act normal.
 set cursorline                 " Highlights the line the cursor is on.
 set encoding=utf8
 set lz                         " LazyDraw. Do not redraw while running macros, much faster.
 set modelines=0                " Disable modelines, to prevent some security exploits.
 set mouse=a
 set noinsertmode               " Enforce in case of EZ-mode.
 set scrolloff=3                " Minimal number of screen lines to keep above and below the cursor.
 set showcmd                    " When a command is in progress, show it in the status bar.
 set showmode                   " Show when in insert/overtype mode.
 set ttyfast                    " Faster drawing on fast terminals.
 set wildmenu                   " Autocompletion operates in enhanced mode. 
 set wildmode=list:longest
 set virtualedit=all            " By default, vim doesn't let the cursor stray beyond the defined text. 
                                " This setting allows the cursor to freely roam anywhere it likes in command mode. 
                                " It feels weird at first but is quite useful.

 set ofu=syntaxcomplete#Complete
 set pastetoggle=<F2>

" Backups
"set nobackup                   " Dont create annoying backup files.
 set backupdir=~/.vim/backupdir

" Recovery options
 set directory=~/.vim/recoverydir

" Persistent undo
 set undofile
 set undodir=~/.vim/undodir
 set undolevels=1000            " Maximum number of changes that can be undone.
 set undoreload=10000           " Maximum number of lines to save for undo on a buffer reload.

" Line numbers
 set nu!                        " Show line numbers.

" Statusline
 set ruler                      " Turn on the ruler (status info) at the bottom of the screen.
 set statusline=%F%m%r%h%w\ FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v]\ [LEN=%L]\ [%p%%]
 set laststatus=2

" Long lines
 set nowrap                     " Don't wrap text.
 set textwidth=80
 set formatoptions=qrn1
"set colorcolumn=80

" Searching
" The first two lines fix vim's broken default regex "handling" by automatically inserting a \v before any string you search for. 
" This turns off vim's default regex characters and makes searches use normal regexes.
" ignorecase and smartcase together make vim deal with case-sensitive search intelligently. 
" If you search for an all-lowercase string your search will be case-insensitive, but if one or more characters is uppercase the search will be case-sensitive. 
" gdefault applies substitutions globally on lines. Instead of :%s/foo/bar/g just type :%s/foo/bar/
" If you need to substitute only the first occurrence on a line add the final g again. 
" incsearch, hlsearch and showmatch work together to highlight search results as you type. 
" The <leader><space> mapping makes it easy to clear out a search by typing ,<space>
" This gets rid of distracting  highlights once you found what you're looking for. 
" The last two lines make the tab key natch bracket pairs. Tab is a lot easier to type than %.
"nnoremap / /\v
"vnoremap / /\v 
 set ignorecase                 " Do case-insensitive searching.
 set smartcase                  " When a search phrase has uppercase, don't be case insensitive.
 set gdefault                   " 
 set incsearch                  "                   " 
 set hlsearch                   " Highlight search results.
 set showmatch                  " Show matches for braces, parens, etc.
                                " This setting will cause the cursor to very briefly jump to a brace/parenthese/bracket's "match" whenever you type a closing or opening brace/parenthese/bracket. I've had almost no mismatched-punctuation errors since I started using this setting.
 set isk+=_,$,@,%,#,-,?,%,&     " None of these should be word dividers.
 set matchpairs+=<:>            " Make < and > match as well
"set matchtime=3                " Show matching brackets for only 0.3 seconds
 nnoremap <leader><space> :noh<cr>
 nnoremap <tab> %
 vnoremap <tab> %

" Indenting
" The first setting sets up 4-space tabs, and the second tells vim to use 4 spaces when text is indented (auto or with the manual indent adjustmenters.)
 set tabstop=2                  " Number of spaces for tab character.
 set shiftwidth=2               " Number of spaces for autoindent and soft tab stops.
 set softtabstop=2              " Backspace fake tabs.
 set expandtab                  " Do expand tabs into spaces.

" The first setting tells vim to use "autoindent" (that is, use the current line's indent level to set the indent level of new lines). 
" The second makes vim attempt to intelligently guess the indent level of any new line based on the previous line, assuming the source file is in a C-like language. 
" Combined, they are very useful in writing well-formatted source code.
 set autoindent                 " Indent in a smart way, instead of returning to the left margin all the time. 
 set smartindent                " 
 set smarttab                   " When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.  
                                " 'tabstop' or 'softtabstop' is used in other places.  
                                " A <BS> will delete a 'shiftwidth' worth of space at the start of the line.  
                                " When off, a <Tab> always inserts blanks according to 'tabstop' or 'softtabstop'.  
                                " 'shiftwidth' is only used for shifting text left or right |shift-left-right|.  
                                " What gets inserted (a <Tab> or spaces) depends on the 'expandtab' option.  

" Folding : http://vim.wikia.com/wiki/Syntax-based_folding, see comment by Ostrygen 
 set foldenable
 set foldmethod=syntax

" http://arun.wordpress.com/2009/04/10/c-and-vim/

" Turn off annoying error bells. 
 set noerrorbells
 set visualbell
 set t_vb=

" Invisible characters
 set list
 set listchars=tab:▸\ ,eol:¶ 

" Erlang vimerl plugin config
"let g:erlangHighlightBif=1
"let g:erlangFoldSplitFunction=1

" Mappings

" While in insert, press j twice to go into command mode. Words or variables with two j's in a row are very rare.
 imap jj <C-[>

" Tab switching
 nmap ,, :tabnew<CR>
 nmap ,. :tabnext<CR>
 nmap ., :tabpre<CR>

" While in insert, automatically set paste, paste, and then set nopaste.
 imap <Leader>v  <C-O>:set paste<CR><C-r>*<C-O>:set nopaste<CR>  

" If we weren't about to disable the arrow keys entirely, this would make them move as expected with wrapped lines in insert mode.
 inoremap <up>   <C-o>gk
 inoremap <down> <C-o>gj

" Disable arrow keys to force you to learn to use the hjkl. 
" Also, make cursor move as expected with wrapped lines in insert mode.
 nnoremap <up>    <nop>
 nnoremap <down>  <nop>
 nnoremap <left>  <nop>
 nnoremap <right> <nop>
" I like to keep these to make small movements while in insert mode.
"inoremap <up>    <nop>
"inoremap <down>  <nop>
"inoremap <left>  <nop>
"inoremap <right> <nop>
 nnoremap j       gj
 nnoremap k       gk

" Disable help key.
 inoremap <F1>    <ESC>
 nnoremap <F1>    <ESC>
 vnoremap <F1>    <ESC>

" Remap ; to : to avoid having to press shift all the time. It's no good on a latinamerican keyboard where both ; and : require shift. 
"nnoremap ; :

" Quickly save a file as root
 cmap w!! %!sudo tee > /dev/null %

" Fast split movement
 nmap <C-j> <C-w>j
 nmap <C-k> <C-w>k
 nmap <C-h> <C-w>h
 nmap <C-l> <C-w>l

" Center search results on the screen
 nmap n     nzz
 nmap N     Nzz
 nmap *     *zz
 nmap #     #zz
 nmap g*    g*zz
 nmap g#    g#zz

" This beauty remembers where you were the last time you edited the file, and returns to the same position.
 au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
 
" Toggles line number mode.
 function! g:ToggleNuMode() 
     if(&rnu == 1) 
         set nu 
     else 
         set rnu 
     endif 
 endfunc 
 nnoremap <C-L> :call g:ToggleNuMode()<cr> 

