set nocompatible 
behave xterm

au!
"au BufNewFile,BufRead * set expandtab
au BufNewFile,BufRead *.java call Java_setup()

au BufNewFile,BufRead *.xml set foldmethod=syntax

au BufNewFile,BufRead *.pl call Perl_setup()

"au BufNewFile,BufRead *.cc call C_setup()
"au BufNewFile,BufRead *.c call C_setup()
"au BufNewFile,BufRead *.h call C_setup()
"au GUIEnter * simalt ~x 
"au BufEnter,BufNewFile,BufRead *.css set nocindent
"au BufLeave *.css set cindent
autocmd BufNewFile,BufRead *.mobile.erb set filetype=eruby.html

autocmd FileType html set tabstop=4|set shiftwidth=4|set noexpandtab
autocmd FileType eruby.html set tabstop=4|set shiftwidth=4|set noexpandtab
autocmd FileType scss set tabstop=4|set shiftwidth=4|set noexpandtab


autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

filetype plugin on
syntax on

set titlelen=40
set ai
set nowrap
set noequalalways
set expandtab
set scrolloff=3
set hlsearch "highlight search
set incsearch "inc search
set guioptions=+m "menubar
set guioptions=-t "tearoff menus
"set guioptions=+r "right hand scroll bar
"set guioptions=+a "autoselect
set ff=unix
set nosplitbelow
set splitright
set guifont=DejaVu\ Sans\ Mono\ 10


set tabstop=2
set shiftwidth=2
set smarttab
"set noexpandtab
"set cindent
set incsearch
set wmh=1
set wmw=1

set exrc			" enable per-directory .vimrc files
set secure			" disable unsafe commands in local .vimrc files

 
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
"set mousemodel=popup
"aunmenu PopUp
"menu PopUp.-Sep- :
"menu PopUp.-Sep3- :

"hi Statement guifg=Maroon
hi Normal guifg=grey80 guibg=grey20
hi Folded guifg=grey70 guibg=grey30
"hi StatusLine guifg=DarkCyan guibg=White
"hi VertSplit guifg=DarkCyan guibg=Black
"hi StatusLineNC guifg=LightSlateBlue


let Tmenu_ctags_cmd = "c:\tools\ctags552\ctags"
let mapleader = ","

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Open, split, or tab relative to the directory of the current file.
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

"MAPS
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-H> <C-W>h<C-W>\|
map <C-L> <C-W>l<C-W>\|
nmap <silent> <C-N> :silent noh<CR>
"inoremap ( ()<ESC>i
"inoremap [ []<ESC>i
"inoremap < <><ESC>i
inoremap # X#
if has("unix")
  map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
else
  map ,e :e <C-R>=expand("%:p:h") . "\\" <CR>
endif
map ,gtd :!~/bin/gtd -c,work,computer %<C-M>:e<C-M><C-M>
" NERDTree
map <C-O> <Esc>:NERDTreeToggle<CR> "Toggle the file browser
map <C-M-O> <Esc>:NERDTreeFind<CR> "Find the current file in the file browser
"

"COMMANDS
com! Q :q
com! Qa :qa
com! W :w
com! Wa :wa
com! WA :wa
com! WQ :wq
com! Wq :wq
com! E :e
com! Redo :redo
com! EmptyQuote :s/\".*\"/\"\"/
com! EmptyParam :s/(.*)/()/
"com! T :!ctags *
com! Sv :source ~/.vimrc
com! Vv :split ~/.vimrc
com! CdServices :cd c:\cvs\services
com! SplitsExplore :call SplitsExplore()
com! StartServices :call StartServices()
com! StartWebinterface :call StartWebinterface()
com! Gtd :call Gtd()

com! RepairManipulators /get_:s/get_/get//getlllvU/set_:s/set_/set//setlllvU0

let g:explVertical=1
let g:explStartRight=0
"let g:netrw_scp_cmd="c:\\cygwin\\bin\\scp -q"
"let g:netrw_cygwin=1
let g:netrw_preview   = 1
let g:netrw_liststyle = 3
let g:netrw_winsize   = 30

let g:ruby_debugger_debug_mode = 1

let g:local_vimrc = '.vimrc.local'

function! Java_setup()
  set titlelen=80

  let b:jcommenter_class_author='<a href="mailto:mcraig@visiblepath.com">Micah Craig</a>'
  let b:jcommenter_file_author='Micah Craig <mcraig@visiblepath.com>'

  set foldnestmax=4
  syn region myFold start="{" end="}" transparent fold
  syn sync fromstart
  set foldmethod=syntax

  map  aSystem.out.println(
  imap  System.out.println(
  "map  :SaveMake
  "map  :SaveRun

  "set makeprg=ant
  "set efm=\ %#[javac]\ %#%f:%l:%c:%*\\d:%*\\d:\ %t%[%^:]%#:%m,
  " \%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#
endfunction

function! C_make()
  :make
endfunction
function! C_save_make()
  w
  call C_make()
endfunction

function! C_run()
  !make run
endfunction
function! C_save_run()
  w
  call C_run()
endfunction
function! C_split_h()
  split %<.h
endfunction
function! C_setup()
  set nocindent
  set titlelen=25
  com! Run :call C_run()
  com! SaveRun :call C_save_run()
  com! Make :call C_make()
  com! SaveMake :call C_save_make()
  com! Split :call C_split_h()
  map  :call C_split_h()x_
  map  printf( "
  imap  printf( "
  map  :SaveMake
  map  :Run
endfunction

function! Perl_setup()
  set titlelen=25
  com! Run :call Perl_run()
  com! SaveRun :call Perl_save_run()
  map  aprint "
  imap  print "
  map  :SaveRun
endfunction

function! Perl_run()
  !./%
endfunction

function! Perl_save_run()
  w
  call Perl_run()
endfunction

function! SubUpperUnder(old,newer)
  let line = getline(".")
  let old = a:old
  let new = a:newer
  let line2 = substitute(line, old, new, "")
  let u_old = toupper(old)
  let u_new = toupper(new)
  let line = substitute(line2, u_old, u_new, "")
  let result = setline(".", line)
endfunction
command! -nargs=+ -complete=command SubUpperUnder call SubUpperUnder(<f-args>)

" 3rd party
function! Foldsearch(search)
  set foldmethod=manual
  normal zE
  normal G$

  let folded = 0
  let flags = "w"
  let line1 =  0
  while search(a:search, flags) > 0
    let  line2 = line(".")
    if (line2 -1 > line1)
      execute ":" . line1 . "," . (line2-1) . "fold"

      let folded = 1
    endif
    let line1 = line2
    let flags = "W"
  endwhile
  normal $G
  let  line2 = line(".")
  if (line2  > line1 && folded == 1)
    execute ":". line1 . "," . line2 . "fold"
  endif
  normal gg
endfunction
" Command is executed as ':Fs pattern'"
command! -nargs=+ -complete=command Fs call Foldsearch(<q-args>)
" View the methods and variables in a java source file."
command! Japi Fs public\|protected\|private
command! Rapi Fs ^..def

function! Options()
  exe "pts /^" . expand("<cword>")
endfunction

nmap <TAB> :call Options()<CR>

set statusline=\#%n\-   "buf number
set statusline+=%{fugitive#statusline()}
set statusline+=%{ruby_debugger#statusline()}
set statusline+=%y      "filetype
set statusline+=%f      "tail of the filename
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

" PATHOGEN
call pathogen#infect()
call pathogen#helptags()
		
set background=dark
colorscheme solarized
hi Search guifg=#268bd2
"Invisible character colors
highlight NonText guifg=#4a4a59
highlight clear SpecialKey
highlight SpecialKey guifg=#4a4a59
