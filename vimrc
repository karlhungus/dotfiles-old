" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" required for vundle
set nocompatible

" Some Linux distributions set filetype in /etc/vimrc.
" Clear filetype flags before changing runtimepath to force Vim to reload them.
" required for vundle
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


Plugin 'wincent/command-t'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-endwise'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'jpo/vim-railscasts-theme'
Plugin 'scrooloose/nerdtree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set mouse=a
set cb=autoselect

"filetype plugin indent off
"set runtimepath+=$GOROOT/misc/vim
"filetype plugin indent on
syntax on

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if $TMUX == ''
  set clipboard+=unnamed
endif

set nobackup
set nowritebackup
set history=50 " keep 50 lines of command line history
set ruler      " show the cursor position all the time
set relativenumber              " use relative line numbers
set cursorline                  " highlight the current line
set showcmd    " display incomplete commands
set incsearch  " do incremental searching
set visualbell
set directory=~/tmp

" Make vim fast
set synmaxcol=300
set ttyfast
set ttyscroll=3
set lazyredraw
set noswapfile

au VimResized * exe "normal! \<c-w>="
nnoremap * *<c-o>
" Faster Esc
inoremap jk <esc>

" Align text
nnoremap <leader>Al :left<cr>
nnoremap <leader>Ac :center<cr>
nnoremap <leader>Ar :right<cr>
vnoremap <leader>Al :left<cr>
vnoremap <leader>Ac :center<cr>
vnoremap <leader>Ar :right<cr>

" Git
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif

" Switch wrap off for everything
" set nowrap

set textwidth=120               " number of columns before linewrap
set colorcolumn=+1              " highlight the column that code shouldn't extend beyond
hi ColorColumn guibg=#2d2d2d ctermbg=246

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Set File type to 'text' for files ending in .txt
  autocmd BufNewFile,BufRead *.txt setfiletype text

  " Enable soft-wrapping for text files
  autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist

  autocmd FileType html,xml,xsl,php,jsp,eruby let b:closetag_html_style=1
  autocmd FileType html,xml,xsl,php,jsp,eruby source ~/.vim/scripts/closetag.vim

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Automatically load .vimrc source when saved
  autocmd BufWritePost .vimrc source $MYVIMRC

  augroup END

else

  set autoindent " always set autoindenting on

endif " has("autocmd")

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Always display the status line
set laststatus=2

" \ is the leader character
let mapleader = ","

" Leader shortcuts for Rails commands
map <Leader>m :Rmodel
map <Leader>c :Rcontroller
map <Leader>v :Rview
map <Leader>u :Runittest
map <Leader>f :Rfunctionaltest
map <Leader>tm :RTmodel
map <Leader>tc :RTcontroller
map <Leader>tv :RTview
map <Leader>tu :RTunittest
map <Leader>tf :RTfunctionaltest
map <Leader>sm :RSmodel
map <Leader>sc :RScontroller
map <Leader>sv :RSview
map <Leader>su :RSunittest
map <Leader>sf :RSfunctionaltest

map :RubyHashConvert :s/\v:([^ ]+)\s*\=\>/\1:/g
map <Leader>h :RubyHashConvert<CR>

map <F6> :NERDTreeToggle<cr>
map ` :NERDTreeToggle<cr>

" https://wincent.com/blog/2-hours-with-vim
function! AckGrep(command)
  cexpr system("ack " . a:command)
  cw " show quickfix window already
endfunction

command! -nargs=+ -complete=file Ack call AckGrep(<q-args>)
map <leader>f :Ack<space>
" previous ack result
map <leader>[ :cp<CR>
" next ack result
map <leader>] :cn<CR>

map <leader>c "+y
map <leader>v "+p
map <leader>u :u<CR>

" Command-t settings
nmap <silent> <C-P> :CommandT<CR>
map <leader>t :CommandT<CR>
set wildignore+=*.gif,*.png,*.jpg,*.jpeg,*.bmp,*.tiff,*.psd,*.svg,*.woff,*.eot,*.ttf
set wildignore+=*/.git/*,*/.svn/*,*/log/*,*/vendor/*,*/tmp/*
let g:CommandTWildIgnore=&wildignore . ",**/node_modules/*"
let g:CommandTFileScanner="git"
let g:CommandTFileScanner="find"
let g:CommandTMatchWindowAtTop=1
let g:CommandTCancelMap='<Esc>'
let g:CommandTSelectNextMap='<Down>'
let g:CommandTSelectPrevMap=['<C-p>', '<C-k>', '<Esc>OA', '<Up>']
map <leader>r :CommandTFlush<CR>

" Maps autocomplete to tab
imap <Tab> <C-N>

" Display extra whitespace
set list listchars=tab:\ \ ,trail:·

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Color scheme
set t_Co=256 " Lets you use 256 colors
colorscheme railscasts
" colorscheme vividchalk
" highlight NonText guibg=#060606
" highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Numbers
set numberwidth=5

"" line numbers
function! ToggleLineNumberMode()
  if(&relativenumber == 1)
    set relativenumber!
    set number
  else
    set number!
    set relativenumber
  endif
endfunc

nmap <leader>l :call ToggleLineNumberMode()<CR>

" Snippets are activated by Shift+Tab
" let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full
set complete=.,t

" case only matters with mixed case expressions
set ignorecase
set smartcase
set spell spelllang=en_us

" Tags
" command! Ctr !/usr/local/bin/ctags -R --languages=ruby . ~/.gemdir/
let g:Tlist_Ctags_Cmd="ctags -R ."
set tags=tags,gems.tags

map <Leader>g :!ctags . <CR>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_eruby_ruby_quiet_messages = { 'regex': 'possibly useless use of a variable in void context' }
" let g:syntastic_ruby_checkers = ["mri", "rubocop"]
let g:syntastic_ruby_checkers = ["rubocop"]

let g:syntastic_javascript_checkers = ["jshint", "eslint", "jsxhint"]

" Airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
" http://sourceforge.net/mailarchive/forum.php?thread_name=AANLkTinkbdoZ8eNR1X2UobLTeww1jFrvfJxTMfKSq-L%2B%40mail.gmail.com&forum_name=tmux-users

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

  "autocmd VimLeave * :!echo -ne "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"

  if &term =~ "xterm\\|rxvt"
    " Changes the cursor between a Block and Line when in Insert mode or not.
    " These escape codes only work in iTerm2
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    autocmd VimLeave * :!echo -ne "\<Esc>]50;CursorShape=0\x7"
  endif
endif

set secure
