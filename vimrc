"\ \    / (_)         |  __ \     
" \ \  / / _ _ __ ___ | |__) |___ 
"  \ \/ / | | '_ ` _ \|  _  // __|
"   \  /  | | | | | | | | \ \ (__ 
"    \/   |_|_| |_| |_|_|  \_\___|

" Lines 1-7 settings are for use with iPads
" Setting the color scheme
" colorscheme torte
"
" Increase font size on iOS. See :help ifont for more info. 
"   Set font temporarily in iVim, e.g. :ifont 1 18
" set guifont=SourceCodePro-Regular:h19


" ---
" Environment variables
" ---

" This sets a variable to allow me to quickly edit my vimrc
let $RC="$HOME/.vim/vimrc"

" This sets a variable to allow me to quickly edit my bash_profile
let $BP="$HOME/.bash_profile"

" ---
" General Vim Settings
" ---

" This is a mode that turns off compatibilty with old VI.
set nocompatible

" Relative to current file and everything under :pwd
set path=.,** 

" This keeps the cursur near the center of the screen
set scrolloff=4
" set scrolloff=99

"Setting my leader key
:let mapleader=","

" Disable the default Vim startup message.
set shortmess+=I

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" This should save vim after every 10 characters
set updatecount=10

" This should allow more searchable history
set history=8192 " more history

" Change cursor during insertion
let &t_SI="\033[5 q" " start insert mode, switch to blinking cursor
let &t_EI="\033[1 q" " end insert mode, back to square cursor

" This allows me to move away from buffers in Vim without writing to disk
set hidden

" ---
" Mappings
" ---

" Maps ctrl+s to save note that I added stty -ixon to my bash_profile
" for this to work correctly
noremap <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" Maps leader em to be an em dash because I am tired of digraphs and use em dash often
inoremap <leader>em <C-k>-M

" Easier moving between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" This is to map spell check to on or off based on pressing the leader key
:nnoremap <leader>s :setlocal spell! spelllang=en_us<cr>

" This is to automatically spell check to the first suggested answer
" and fixes it without moving the cursor
function! FixLastSpellingError()
normal! mm[s1z=`m"
endfunction
nnoremap <leader>cs :call FixLastSpellingError()<cr>

" Vertically center the document when insert mode
autocmd InsertEnter * norm zz

" General key mappings to make life a bit easier
:nnorema j gj "These make the cursor move up and down by screen number
:map k gk
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
:map ; :
:inoremap jj <esc>

" Allows me to open files in Marked 2
:nnoremap <leader>m :silent !open -a Marked\ 2.app '%:p'<cr>

" Visually select pasted or yanked text
nnoremap gV `[v`]

" ----
" Basic Editing Config
" ---

" This ignores case in search unless I use capitals.
set ignorecase
set smartcase

" Open new splits panes to the right and bottom, which feels more natural
set splitbelow
set splitright

" Tab completion for files/buffers
set wildmode=list:longest
set wildmenu

" Making sure there is a couple lines between the top and bottom of the file
set foldcolumn=1
set scrolloff=12

" Syntax highlighting
syntax on:

" Specifying search colors to see cursur
highlight clear Search
highlight       Search    ctermfg=White  ctermbg=Black  cterm=bold
highlight    IncSearch    ctermfg=White  ctermbg=Red    cterm=bold

" Setting relative line numbering
set rnu

" Show line numbers. With both rel and normal line num
" the current line will show the actual line number while
" the other lines will be relative.
set number

" more powerful backspacing
set backspace=indent,eol,start

" Making the lines wrap normally
set linebreak

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" This remaps nerdtree to ctrl+n
map <C-n> :NERDTreeToggle<CR>

" This allows me to use my own editing template system
" where <++> serve as place holders
inoremap <Tab><Tab><Tab> <Esc>/<++><Enter>"_c4l

" This is a more sane copy to the system clipboard for macOS
noremap <Leader>Y "+y

"-----------------
" Markdown Specific Settings
"-----------------

" This function turns lines of text and makes them
" markdown headers
function! UnderlineHeading(level)
if a:level == 1
:execute "normal! I#\<space>\<esc>o"
elseif a:level == 2
:execute "normal! I##\<space>\<esc>o"
else
:execute "normal! I###\<space>\<esc>o"
endif
endfunction

nnoremap <leader>h1 :call UnderlineHeading(1);
nnoremap <leader>h2 :call UnderlineHeading(2);
nnoremap <leader>h3 :call UnderlineHeading(3);

" ---
" Managing Plugins
" I am not using a plugin manager becuase they seem useless at this point since
" vim has built in plug in support. Thus, they are just installed in the directory
" ~/.vim/pack/vendor/start. To get them in there I am using the 'git clone' command
" and just placing the URL of the plugin after the command.
" ---

" I am currently using:
" Goyo [I am resizing the width]
" I am also using NerdTree
" I am also using vim-airline
" I am also using FZF fuzzy finder
set rtp+=~/.fzf

" This should allow me to insert the date by typing xdate
" iab xdate <C-r>=strftime(“%d/%m/%y %H:%M:%S”)<cr>

"---------------------------
" This section is a list of things that I commonly
" misspell and that I want Vim to autocorrect for me
" or for which a text expansion would make typing efficient
"---------------------------
:iabbrev teh the
:syntax keyword WordError teh

:iabbrev ddr Dr. Okdie
:syntax keyword WordError ddr

" Insert time and date stamp in the current buffer
:iab <expr> xdts strftime("%F %X")

:iabbrev EE Executive Editors
:syntax keyword WordError EE
