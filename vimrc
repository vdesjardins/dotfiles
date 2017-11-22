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

  set langmenu=en_US.UTF-8  " sets the language of the menu (gvim)
  language English          " sets the language of the messages / ui (vim)

  au GUIEnter * simalt ~n
endif

filetype off

" vim-plug setup --------------------------- {{{

if MySys() ==? "windows"
  if has('nvim')
    let s:autoloaddir = expand('~\AppData\Local\nvim\autoload')
  else
    let s:autoloaddir = expand('~\vimfiles\autoload')
  endif

  if empty(glob(expand(s:autoloaddir . '\plug.vim')))
    silent execute "!powershell -NoProfile -Command " .
         \ "New-Item -ItemType Directory -Force -Path " . s:autoloaddir
    silent execute "!powershell -NoExit -NoProfile -Command " .
         \ "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim', " .
         \ "'" . s:autoloaddir . "\\plug.vim')"
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  let s:vimplugdir = expand('~\vimfiles\plugged')
else
  if has('nvim')
    let s:autoloaddir = expand('~/.local/share/nvim/site/autoload')
  else
    let s:autoloaddir = expand('~/.vim/autoload')
  endif

  if empty(glob(s:autoloaddir . '/plug.vim'))
    silent execute "!curl -fLo " . s:autoloaddir . "/plug.vim --create-dirs " .
         \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  let s:vimplugdir = expand('~/.vim/plugged')
endif

call plug#begin(s:vimplugdir)

Plug 'archSeer/colibri.vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'vim-syntastic/syntastic'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'kien/rainbow_parentheses.vim'
Plug 'airblade/vim-gitgutter'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'tpope/vim-endwise'
Plug 'airblade/vim-rooter'
Plug 'houtsnip/vim-emacscommandline'
Plug 'mhinz/vim-grepper'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-go'
Plug 'vim-scripts/L9'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'cespare/vim-toml'
Plug 'vim-scripts/tComment'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-repeat'
Plug 'ekalinin/Dockerfile.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'edkolev/promptline.vim'
Plug 'vim-scripts/logstash.vim'
Plug 'regedarek/ZoomWin'
Plug 'junegunn/vim-easy-align'
Plug 'editorconfig/editorconfig-vim'
Plug 'pearofducks/ansible-vim'
Plug 'vim-scripts/TaskList.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sbdchd/neoformat'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'tpope/vim-rake'
Plug 'tpope/gem-browse'
Plug 'tpope/vim-bundler'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'pbogut/fzf-mru.vim'
Plug 'junegunn/fzf.vim'
Plug 'PProvost/vim-ps1'
Plug 'leafgarland/typescript-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'
Plug 'vdesjardins/vim-langclient-java'
" Plug 'roxma/python-support.nvim'

"Plug 'icholy/typescript-tools'

call plug#end()

" }}}

syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins
set mouse=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
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

nnoremap <leader>ws :StripWhitespace<cr>

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

highlight TabLineSel ctermbg=2
highlight ExtraWhitespace ctermbg=167 guibg=#fb4934

" Remove toolbar
set guioptions-=T

" Disable ALT keys for menu
set winaltkeys=no

" Completion only on the longest text entered
" set completeopt+=longest
" set completeopt=menu,preview

let g:deoplete#enable_at_startup = 1

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
  autocmd FileType xml set ai sw=4 sts=4 et
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

" Grepper mapping ---------------------------------------- {{{
nnoremap <leader>* :Grepper
nnoremap <leader>a :Grepper -tool rg --vimgrep --no-heading<cr>
nnoremap <leader>ack :Grepper -tool ack -cword -noprompt<cr>
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
" Always show the statusline
set laststatus=2
" }}}

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

" }}}

" Cope (quickfix) ---------------------------------- {{{
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
  autocmd FileType ruby,eruby let g:ycm_collect_identifiers_from_tags_files = 1
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
" golang
augroup go_group
  autocmd!
  autocmd FileType go nmap <localleader>s <Plug>(go-implements)
  autocmd FileType go nmap <localleader>d <Plug>(go-def)
  autocmd FileType go nmap <localleader>gd <Plug>(go-doc)
  autocmd FileType go nmap <localleader>gv <Plug>(go-doc-vertical)
  autocmd FileType go nmap <localleader>r <Plug>(go-run)
  autocmd FileType go nmap <localleader>b <Plug>(go-build)
  autocmd FileType go nmap <localleader>t <Plug>(go-test)
  autocmd FileType go nmap <localleader>c <Plug>(go-coverage)
  autocmd FileType go nmap <localleader>e <Plug>(go-rename)
  autocmd FileType go nmap <localleader>i <Plug>(go-imports)
  autocmd FileType go nmap <localleader>m :make<cr>
augroup END

let g:go_bin_path = expand("~/.gotools")
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_auto_type_info = 1
" }}}

" Vim grep ------------------------------------------ {{{
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated .git log logs tmp'
set grepprg=rg\ --vimgrep
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

" }}}

" FZF --------------------------------- {{{
let g:fzf_buffers_jump = 1
let g:fzf_command_prefix = 'FZF'
noremap <leader>t :FZF<cr>
noremap <leader>b :FZFBuffers<cr>
noremap <leader>f :FZFTags<cr>
noremap <leader>m :FZFMarks<cr>


command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

noremap <leader>g :Rg<cr>

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

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = "quickfix"
let g:syntastic_java_checkers = ['checkstyle']

" }}}

" ZoomWin -------------------------------- {{{
noremap <leader>z :ZoomWin<CR>
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

" Ansible section --------------------------------------------- {{{
augroup ansible_group
  autocmd!
  autocmd FileType ansible,ansible_host setlocal keywordprg=:te\ ansible-doc
  autocmd BufRead,BufNewFile */playbooks/*.yml,*/playbooks/*.yaml set filetype=ansible
augroup END
" }}}

" Task List --------------------------------------------- {{{
map <leader>v <Plug>TaskList
" }}}
"
" Java --------------------------------------------- {{{
function! neoformat#formatters#xml#tidy() abort
  return {
        \ 'exe': 'tidy',
        \ 'args': ['-quiet',
        \          '-xml',
        \          '--indent auto',
        \          '--indent-spaces ' . shiftwidth(),
        \          '--vertical-space yes',
        \          '--tidy-mark no',
        \          '-utf8'
        \         ],
        \ 'stdin': 1,
        \ }
endfunction

let g:langclient_java_autostart = 1

augroup java_group
  autocmd!
  autocmd FileType java set makeprg=mvn\ compile\ -q\ -f\ pom.xml
  autocmd BufNewFile,BufRead pom.xml set makeprg=mvn\ compile\ -q\ -f\ pom.xml
  autocmd FileType java set errorformat=\[ERROR]\ %f:[%l\\,%v]\ %m
  autocmd FileType java nmap <localleader>m :make<cr>
  autocmd BufWritePre * :Neoformat

  autocmd FileType java nmap K :call LanguageClient_textDocument_hover()<CR>
  autocmd FileType java nmap <C-]> :call LanguageClient_textDocument_definition()<CR>
  autocmd FileType java nmap <localleader>e :call LanguageClient_textDocument_rename()<CR>
  autocmd FileType java nmap <localleader>/ :call LanguageClient_textDocument_documentSymbol()<CR>
  autocmd FileType java nmap <localleader>r :call LanguageClient_textDocument_references()<CR>
  autocmd FileType java nmap <localleader>g :call LanguageClient_workspace_symbol()<CR>
  autocmd FileType java nmap <localleader>a :call LanguageClient_textDocument_codeAction()<CR>
  autocmd FileType java nmap <localleader>f :call LanguageClient_textDocument_formatting()<CR>
  autocmd FileType java nmap <localleader>h :call LanguageClient_textDocument_signatureHelp()<CR>
augroup END

" }}}

" easytags --------------------------------------------- {{{
set tags=./tags;
let g:easytags_dynamic_files = 1
" }}}
"
" snippet --------------------------------------------- {{{
set tags=./tags;
noremap <leader>es :e! ~/.vim/UltiSnips/<cr>
" }}}

" session --------------------------------------------- {{{
let g:session_autosave = 'no'
" }}}

syntax on

" Colors and Fonts ---------------------- {{{
set t_Co=256
set background=dark
set termguicolors
colorscheme colibri
if MySys() ==? "windows"
  set guifont=Lucida_Console:h10:cANSI
endif
" }}}

