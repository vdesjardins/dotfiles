""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vincent Desjardins (vdesjardins@gmail.com)
" Date: 2010/10/01 21:48:28
"
set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MySys()
  if has("win32") || has("win64")
    return "windows"
  elseif has("unix")
    return "unix"
  endif
endfunction

" force eencoding to utf-8 on windows
if MySys() ==? "windows"
  if has("multi_byte")
    if &termencoding ==? ""
      let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    "setglobal bomb
    set fileencodings=ucs-bom,utf-8,latin1
  endif
endif

" Vundle Setup --------------------------- {{{
filetype off

" With NFS shared home directory we want to be able to use compiled plugin
" modules with different library versions. To help that if a directory named
" with the hostname is present in the .vim directory we will load plugins from
" there.
let s:vundle_plugin_path = expand("~/.vim/bundle")
if MySys() ==# "unix"
  let s:hostname = substitute(system('hostname'), '\n', '', '')
  let s:plugin_path = expand("~/.vim/" . s:hostname)

  if isdirectory(s:plugin_path)
    let s:vundle_plugin_path = s:plugin_path
  endif
endif

" We're always using the default vundle to start things up.
set rtp+=~/.vim/bundle/vundle/
call vundle#begin(s:vundle_plugin_path)
Plugin 'gmarik/vundle'
Plugin 'fatih/vim-go'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'rainbow_parentheses.vim'
Plugin 'puppetlabs/puppet-syntax-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-vividchalk'
Plugin 'tpope/vim-endwise'
Plugin 'airblade/vim-rooter'
Plugin 'houtsnip/vim-emacscommandline'
Plugin 'mileszs/ack.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/L9'
Plugin 'honza/vim-snippets'
Plugin 'SirVer/ultisnips'
Plugin 'cespare/vim-toml'
Plugin 'vim-scripts/tComment'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'sgur/ctrlp-extensions.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'tpope/vim-repeat'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'edkolev/promptline.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'morhetz/gruvbox'
Plugin 'vim-scripts/logstash.vim'
Plugin 'saltstack/salt-vim'
Plugin 'chase/vim-ansible-yaml'
Plugin 'vim-scripts/ZoomWin'
Plugin 'junegunn/vim-easy-align'
Plugin 'editorconfig/editorconfig-vim'

call vundle#end()
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Genral
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=1000          " How many history lines vim remembers.
set autoread              " auto read file changed from the outside

set ttyfast

if v:version >= 703
  set undofile
  set undolevels=1000
  set undodir=~/.vimundo  " Put all undo files in the same directory

  if !isdirectory(&undodir)
    echo "Undo directory (~/.vimundo) does not exists."
  endif

  set colorcolumn=85
endif

set backupdir=~/.vimbkp   " Put all backup files in the same directory
if !isdirectory(&backupdir)
  echo "Backup directory (~/.vimbkp) does not exists."
endif

" Permit extra key combinations
let mapleader = ","
let g:mapleader = ","
let maplocalleader = "\\"

" Fast saving
nnoremap <leader>w :w!<cr>

" Save file with sudo
nnoremap <leader>W :w !sudo tee % > /dev/null<cr>

" Fast editing of the .vimrc
if MySys() ==? "unix"
  noremap <leader>e :e! ~/.vimrc<cr>
else
  noremap <leader>e :e! ~/_vimrc<cr>
endif

" Fast editing of tmux.conf
noremap <leader>x :e! ~/.tmux.conf<cr>

" wHen vimrc is edited, reload it
augroup _vimrc_reload_group
autocmd!
autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

" Switch quicky for pasting text in a SSH session.
set pastetoggle=<F2>

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Add argument (can be negative, default 1) to global variable i.
" Return value of i before the change.
" Example: :let i = 1 | %s/abc/\='xyz_' . Inc()/g
function! Inc(...)
  let result = g:i
  let g:i += a:0 > 0 ? a:1 : 1
  return result
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" modeline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d :",
        \ &tabstop, &shiftwidth, &textwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" User interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical..
set so=7

set wildmenu "Turn on WiLd menu
set wildmode=longest,list:longest
set wildignore=*.swp,*.bak,*.pyc,*.class

set ruler "Always show current position

set cmdheight=2 "The commandbar height

set hid "Change buffer - without saving

" Set backspace config
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=

set nolist
set listchars=tab:▸\ ,eol:¬

hi TabLineSel ctermbg=2

" Remove toolbar
set guioptions-=T

" Disable ALT keys for menu
set winaltkeys=no

" Completion only on the longest text entered
set completeopt+=longest
set completeopt=menu,preview

" Colors and Fonts ---------------------- {{{
set t_Co=256
set background=dark
"colorscheme vividchalk
colorscheme gruvbox
if MySys() ==? "windows"
  set guifont=Lucida_Console:h10:cANSI
endif
" }}}

" Vimscript file settings ---------------------- {{{
augroup vim_group
  autocmd!
  autocmd FileType vim set ai sw=2 sts=2 et
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Text, tab and indent related ---------------------- {{{
augroup myfiletypes_group
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml,ru set ai sw=2 sts=2 et
  autocmd FileType python set ai sw=4 sts=4 et ts=8
  autocmd FileType sh set ai sw=4 sts=4 et ts=8
  autocmd FileType javascript,json set ai sw=2 sts=2 et
  autocmd FileType java set ai sw=4 sts=4 et
  autocmd FileType html set ai sw=2 sts=2 et
  autocmd FileType objc set ai sw=4 sts=4 et
  autocmd FileType sql set ai sw=4 sts=4 et
  autocmd FileType puppet set ai sw=2 sts=2 et
  autocmd FileType spec set ai sw=2 sts=2 et
  autocmd FileType properties set ai sw=2 sts=2 et
  autocmd FileType jproperties set ai sw=2 sts=2 et
augroup END

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif
" }}}

" Visual mode related --------------------------- {{{
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
noremap <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction ==? 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction ==? 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
  elseif a:direction ==? 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" Reslect last text edited or pasted
nnoremap gV `[v`]

" Bubble single lines
nnoremap <C-Up> [e
nnoremap <C-Down> ]e
" bubble multiple lines"{{{"}}}
vnoremap <C-Up> [egv
vnoremap <C-Down> ]egv

" }}}

" Command mode related ---------------------------------- {{{
" Smart mappings on the command line
cnoremap $h e ~/
cnoremap $d e ~/Desktop/
cnoremap $j e ./
cnoremap $p e ~/projects/
cnoremap $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cnoremap $q <C-\>eDeleteTillSlash()<cr>

func! Cwd()
  let cwd = getcwd()
  return "e " . cwd
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() ==? "unix"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd ==? g:cmd_edited
    if MySys() ==? "unix"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc
" }}}

" Ack mapping ---------------------------------------- {{{
nnoremap <leader>a :Ack
if executable("ag")
  let g:ackprg = 'ag --nogroup --nocolor --column'
else
  let g:ackprg = 'ack -H --nocolor --nogroup --column'
endif
" }}}

" Moving around, tabs and buffers ------------------------------------ {{{

" Map space to / (search) and c-space to ? (backgwards search)
noremap <space> /
noremap <c-space> ?

" Clear search highlighting
noremap <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" List buffers
noremap <leader>l :buffers<cr>

" Close the current buffer
noremap <leader>bc :Bclose<cr>

" Close all the buffers
noremap <leader>ba :1,300 bd!<cr>

" Buffer next/previous
noremap <leader>bn :bn<cr>
noremap <leader>bp :bp<cr>

" Use the arrows to something useful
noremap <right> :bn<cr>
noremap <left> :bp<cr>

" Tab configuration
noremap <leader>tn :tabnew %<cr>
noremap <leader>te :tabedit
noremap <leader>tc :tabclose<cr>
noremap <leader>tm :tabmove
noremap <leader>tz :tablast

" When pressing <leader>ccd switch working directory to the directory of the open buffer
noremap <leader>ccd :cd %:p:h<cr>

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") ==? l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Specify the behavior when switching between buffers
try
  set switchbuf=usetab
  set stal=2
catch
endtry

" }}}

" Statusline --------------------------- {{{

" " Always show the statusline
set laststatus=2

" Parenthesis/bracket expanding ----------------------- {{{
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>
" }}}

" General Abbrevs ------------------------------------ {{{
iabbrev vdes Vincent Desjardins
iabbrev xdate <c-r>=strftime("%Y/%m/%d %H:%M:%S")<cr>
iabbrev @@    vdesjardins@gmail.com
iabbrev ccopy Copyright 2014 Vincent Desjardins, all rights reserved.
iabbrev ssig -- <cr>Vincent Desjardins<cr>vdesjardins@gmail.com
" }}}

" Editing mappings --------------------------------------- {{{
"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nnoremap <M-j> mz:m+<cr>`z
nnoremap <M-k> mz:m-2<cr>`z
vnoremap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"Delete trailing white space
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
augroup _delete_trailingWS_group
autocmd!
autocmd BufWrite *.* :call DeleteTrailingWS()
augroup END

" }}}

" Cope ---------------------------------- {{{
noremap <leader>co :botright cope<cr>
noremap <leader>cc :cclose<cr>
noremap <leader>n :cnext<cr>
noremap <leader>p :cprevious<cr>
" }}}

" Help ---------------------------------- {{{
noremap <leader>hc :helpclose<cr>
noremap <leader>hg :helpgrep
" }}}

" bufExplorer plugin ----------------------------- {{{
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
" }}}

" Make Green ------------------------------ {{{
noremap <Leader>] <Plug>MakeGreen
" }}}

" Spell checking ------------------------------- {{{
"Pressing ,ss will toggle and untoggle spell checking
noremap <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
noremap <leader>sn ]s
noremap <leader>sp [s
noremap <leader>sa zg
noremap <leader>s? z=
" }}}

" CSS section -------------------------------------- {{{
augroup css_autocmplete_group
  autocmd!
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
augroup END

" Sort CSS properties
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
" }}}

" Bash section -------------------------------------------- {{{
augroup sh_group
  autocmd!
  autocmd FileType sh inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
augroup END
" }}}

" Ruby section --------------------------------------------- {{{
augroup ruby_group
  autocmd!
  autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
  autocmd FileType ruby inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
  autocmd BufNewFile,BufRead *_spec.rb compiler rspec

augroup END
" }}}

" Python section --------------------------------------------- {{{
augroup python_group
  autocmd!
  autocmd FileType python set nocindent
  autocmd FileType python syn keyword pythonDecorator True None False self

  autocmd BufNewFile,BufRead *.jinja set syntax=htmljinja
  autocmd BufNewFile,BufRead *.mako set ft=mako

  autocmd FileType python inoremap <buffer> $r return
  autocmd FileType python inoremap <buffer> $i import
  autocmd FileType python inoremap <buffer> $p print
  autocmd FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
  autocmd FileType python noremap <buffer> <leader>1 /class
  autocmd FileType python noremap <buffer> <leader>2 /def
  autocmd FileType python noremap <buffer> <leader>C ?class
  autocmd FileType python noremap <buffer> <leader>D ?def

  autocmd FileType python set omnifunc=pythoncomplete#Complete
augroup END

let python_highlight_all = 1
" }}}

" JavaScript section --------------------------------------------- {{{
function! JavaScriptFold()
  setl foldmethod=syntax
  setl foldlevelstart=1
  syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

  function! FoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
  endfunction
  setl foldtext=FoldText()
endfunction

augroup javascript_group
  autocmd!
  "autocmd FileType javascript call JavaScriptFold()
  autocmd FileType javascript setl fen
  autocmd FileType javascript setl nocindent

  autocmd FileType javascript inoremap <c-t> AJS.log();<esc>hi
  autocmd FileType javascript inoremap <c-a> alert();<esc>hi

  autocmd FileType javascript inoremap <buffer> $r return
  autocmd FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi


  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
augroup END
" }}}

" CoffeeScript autocompile on save -------------------------------------- {{{
augroup coffeescript_group
  autocmd!
  autocmd BufWritePost *.coffee silent CoffeeMake! -b | cwindow
augroup END
" }}}

" Markdown -------------------------------------- {{{
augroup markdown_group
  autocmd!
  autocmd BufRead,BufNewFile *.md setlocal spell
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END
" }}}

" gitcommit --------------------------------------- {{{
augroup gitcommit_group
  autocmd!
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell
augroup END
" }}}

" go ------------------------------------------------ {{{
augroup go_group
  autocmd!
  autocmd FileType go nnoremap <localleader>s <Plug>(go-implements)
  autocmd FileType go nnoremap <localleader>i <Plug>(go-info)
  autocmd FileType go nnoremap <localleader>gd <Plug>(go-doc)
  autocmd FileType go nnoremap <localleader>gv <Plug>(go-doc-vertical)
  autocmd FileType go nnoremap <localleader>r <Plug>(go-run)
  autocmd FileType go nnoremap <localleader>b <Plug>(go-build)
  autocmd FileType go nnoremap <localleader>t <Plug>(go-test)
  autocmd FileType go nnoremap <localleader>c <Plug>(go-coverage)
  autocmd FileType go nnoremap <localleader>e <Plug>(go-rename)
augroup END
let g:go_bin_path = expand("~/.gotools")
" }}}

" Vim grep ------------------------------------------ {{{
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated .git log logs tmp'
set grepprg=/bin/grep\ -nH
" }}}

" MISC ---------------------------------------- {{{
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>wm mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Quickly open a buffer for scripbble
noremap <leader>q :e ~/buffer<cr>

" share clipboard with windows clipboard
if MySys() ==? "windows"
  set clipboard+=unnamed
endif

set hidden

" }}}

" Copy filename to clipboard --------------------- {{{
" Convert slashes to backslashes for Windows.
if MySys() ==? "windows"
  nnoremap <Leader>cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
  nnoremap <Leader>cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

  " This will copy the path in 8.3 short format, for DOS and Windows 9x
  nnoremap <Leader>c8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
  nnoremap <Leader>cs :let @*=expand("%")<CR>
  nnoremap <Leader>cl :let @*=expand("%:p")<CR>
  " Add it to the '+' register too for gnome clipboard.
  nnoremap <Leader>cs :let @+=expand("%")<CR>
  nnoremap <Leader>cl :let @+=expand("%:p")<CR>
endif

" YankRing
let g:yankring_history_file=".vimyankring"
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>

" zen-coding
let g:user_zen_settings = {
      \   'indentation': "  ",
      \   'php': {
      \      'extends': 'html',
      \   }
      \}

" For MRU plugin
nnoremap <Leader>r :MRU<space>

" Disable Lusty on windows for now
if MySys() ==? "windows"
  let g:LustyExplorerSuppressRubyWarning = 1
endif

noremap <leader>t :CtrlPMixed<cr>
noremap <leader>b :CtrlPBuffer<cr>
noremap <leader>f :CtrlPTag<cr>
noremap <leader>y :CtrlPYankring<cr>
noremap <leader>m :CtrlPFunky<cr>

let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
      \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir', 'extensions',
      \ 'funky']

" }}}

" Utilities --------------------------------- {{{
" capture ex command output to tab
function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  tabnew
  silent put=message
  set nomodified
endfunction

command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)
" }}}

" rainbow parentheses ------------------------- {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup rainbow_group
  autocmd!
  autocmd VimEnter * RainbowParenthesesToggle
  autocmd Syntax * RainbowParenthesesLoadRound
  autocmd Syntax * RainbowParenthesesLoadSquare
  autocmd Syntax * RainbowParenthesesLoadBraces
augroup END
" }}}

" UltiSnips parentheses ----------------------- {{{
let g:UltiSnipsExpandTrigger = '<c-l>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
" }}}

" tagbar ------------------------------- {{{
nnoremap <F8> :TagbarToggle<CR>
" }}}

" airline -------------------------------- {{{
let g:airline_powerline_fonts = 1
" }}}

" promptline -------------------------------- {{{
let g:promptline_preset = {
        \'a' : [ promptline#slices#host() ],
        \'b' : [ '$USER'],
        \'c' : [ promptline#slices#cwd() ],
        \'y' : [ promptline#slices#vcs_branch(), promptline#slices#jobs() ],
        \'warn' : [ promptline#slices#last_exit_code() ]}
" }}}

" syntastic -------------------------------- {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"

let g:syntastic_python_checkers = ['pylint']
" }}}

" ZoomWin -------------------------------- {{{
noremap <leader>z :call ZoomWin()<CR>
" }}}

" vimrooter -------------------------------- {{{
let g:rooter_patterns = ['.git/']
" }}}

" vim-easy-align -------------------------------- {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}
