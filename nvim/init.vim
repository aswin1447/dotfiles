"         _
"  __   _(_)_ __ ___  _ __ ___
"  \ \ / / | '_ ` _ \| '__/ __|
"   \ V /| | | | | | | | | (__
"    \_/ |_|_| |_| |_|_|  \___|
"
" Author: Niru Maheswaranathan
" Website: https://github.com/nirum/dotfiles

" Plugins ------------------------- {{{

call plug#begin('~/.vim/plugged')

" FZF fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" adds git commands (Gstatus, Gcommit, Gdiff)
Plug 'tpope/vim-fugitive'

" username, repo, and issue completion in commit messages
Plug 'rhysd/github-complete.vim'

" adds +/- symbols to the gutter for modified files
Plug 'airblade/vim-gitgutter'

" proper search highlighhting
Plug 'haya14busa/incsearch.vim'

" tags
Plug 'fntlnz/atags.vim'

" autocompletion
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'zchee/deoplete-jedi'

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" syntax checker (neomake)
Plug 'benekastah/neomake'

" quickscope (underline matches for f/t/F/T navigation)
Plug 'unblevable/quick-scope'

" ys, cs, and ds surround operators
Plug 'tpope/vim-surround'

" adds a bunch of [] mappings
Plug 'tpope/vim-unimpaired'

" adds repeat (.) abilities for surround, unimpaired
Plug 'tpope/vim-repeat'

" add or remove comments easily
Plug 'tomtom/tcomment_vim'

" support for custom text objects (nouns)
Plug 'kana/vim-textobj-user'

" python text objects and motions (af, if, ac, ic, ]pf, ]pc)
Plug 'bps/vim-textobj-python'

" python
Plug 'nirum/vim-cute-python', { 'for': 'python' }

" haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'Twinside/vim-haskellConceal', { 'for': 'haskell' }

" LaTeX
Plug 'lervag/vimtex', { 'for': 'tex' }

" javascript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }

" web
Plug 'valloric/MatchTagAlways', {'for': 'html'}
Plug 'ap/vim-css-color'
Plug 'mattn/emmet-vim', {'for': 'html'}

" other
Plug 'tpope/vim-markdown', { 'for': 'markdown' }

" vim-airline (statusline)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" base16 colorschemes
Plug 'chriskempson/base16-vim'

" gui-goodness
Plug 'ryanoasis/vim-devicons'
Plug 'chrisbra/unicode.vim'

call plug#end()

" }}}

" Basic Settings ---------------------- {{{
syntax on                               " Enable syntax highlighting
filetype plugin indent on               " Enable filetype-specific indenting and plugins
nnoremap <SPACE> <nop>
let mapleader = "\<Space>"              " use the spacebar as my leader
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" 24-bit color!
if has('termguicolors')
  set termguicolors
endif

" use indentation for folding
set foldmethod=indent
set foldlevelstart=4

" tabs and indenting
set tabstop=2 shiftwidth=2 expandtab smartindent

" backup and swap files
set backup undofile
set directory=~/.vim-swp// undodir=~/.vim-undo// backupdir=~/.vim-backup//

" show relative line numbers + the absolute number for the current line
set relativenumber number

" editing
set noesckeys timeoutlen=500

" searching
set gdefault ignorecase smartcase

" update the screen
set nolazyredraw

" command window height
set cmdheight=1

" smooth sidescrolling
set sidescroll=1

" clipboard support in OS X
set clipboard+=unnamed

" }}}

" Plugin settings ----------------------- {{{

" FZF
fun! s:fzf_root()
  let path = finddir(".git", expand("%:p:h").";")
  return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
endfun
nnoremap <silent> <c-t> :exe 'Files ' . <SID>fzf_root()<CR>

" Investigate
let g:investigate_use_dash=1
nnoremap <leader>k :call investigate#Investigate('n')<CR>
vnoremap <leader>k :call investigate#Investigate('v')<CR>

" git and github
let g:github_complete_enable_neocomplete=1
let g:gitgutter_enabled = 1
let g:gitgutter_sign_modified =  '±'
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_map_keys = 0
let g:gitgutter_eager = 1
let g:gitgutter_realtime = 0

" incsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" tags (atags)
autocmd! BufWritePost * call atags#generate()
nnoremap <leader>g :call atags#generate()<cr>

" autocompletion (deoplete)
let g:deoplete#enable_at_startup=1
let deoplete#sources#jedi#show_docstring=1
let g:deoplete#auto_complete_start_length=2
let g:deoplete#disable_auto_complete=0

" deoplete tab-complete
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" syntax checking (neomake)
autocmd! BufWritePost * Neomake
let g:neomake_airline = 1
let g:neomake_error_sign = { 'text': '✘', 'texthl': 'ErrorSign' }
let g:neomake_warning_sign = { 'text': 'ϟ', 'texthl': 'WarningSign' }
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_python_flake8_maker = {'args': ['--ignore=E226,E231']}

" quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" airline preferences
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
let g:airline_theme='base16'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

" }}}

" Generic Mappings ---------------------- {{{

" I need to come up with a better mapping for Q ...
nnoremap Q <nop>

" circular window navigation
nnoremap <tab>   gt
nnoremap <S-tab> gT

" undo after ctrl-c
inoremap <c-c> <c-c>u

" exit insert, dd line, enter insert
inoremap <c-d> <esc>ddi

" clear highlighting
nnoremap <Esc> :noh<CR>

" reduce having to type shift for commands
nnoremap ; :
nnoremap : ;

" swap " and ' for easier registers
nnoremap " '
nnoremap ' "

" yank without jank
vnoremap <expr>y "my\"" . v:register . "y`y"

" insert an underline below the current line
inoremap <C-u> <CR><Esc>kyyp^v$r-o

" }}}

" Leader commands -------------- {{{

" clear whitespace
nnoremap <leader>w :Wsp<CR>

" edit and source $MYVIMRC
nnoremap <leader>erc :tabf $MYVIMRC<CR>
nnoremap <leader>src :source $MYVIMRC<CR>

" undo
nnoremap <leader>u :GundoToggle<CR>

" Folding
nnoremap <leader>a za
nnoremap <leader>A zA
nnoremap <leader>o zo
nnoremap <leader>O zO

" commenting
nmap <leader>c gcc

" }}}

" FileType-specific settings ---------------------- {{{

augroup filetype_vim
  autocmd!
  autocmd FileType vim,zsh setlocal foldmethod=marker
  autocmd BufWritePost .vimrc so $MYVIMRC
augroup END

augroup filetype_python
  autocmd!
  autocmd BufRead,BufNewFile *.ipy set filetype=python
  autocmd FileType python inoremap # X#
  autocmd FileType python setlocal softtabstop=4
  autocmd FileType python setlocal tabstop=4
  autocmd FileType python setlocal shiftwidth=4
augroup END

" }}}

" Abbreviations and Typos ---------------------- {{{

" prose typos
iabbrev adn     and
iabbrev tehn    then
iabbrev waht    what
iabbrev teh     the
iabbrev nriu    niru
iabbrev rnage   range

" }}}

" Highlights, colors and themes ---------------------- {{{

" colorscheme
set background=dark
colorscheme base16-ocean
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete:h16

" highlight past the 100th column
highlight OverLength ctermbg=red ctermfg=white guibg=#A97070
augroup highlighting
  autocmd!
  autocmd FileType python,js match OverLength /\%101v.\+/
augroup END

" }}}

" Functions ---------------------- {{{

" change directory to the root of the git repository
function! s:root()
  let me = expand('%:p:h')
  let gitd = finddir('.git', me.';')
  if empty(gitd)
    echo "Not in git repo"
  else
    let gitp = fnamemodify(gitd, ':h')
    echo "Change directory to: ".gitp
    execute 'lcd' gitp
  endif
endfunction
command! Root call s:root()

" Toggle conceal level
function! g:ToggleConceal()
  if(&conceallevel)
    setlocal conceallevel=0
  else
    setlocal conceallevel=1
  endif
endfunc
command! Cute call g:ToggleConceal()

" removes trailing whitespace
function! g:RemoveTrailingWhitespace()
  let l = line(".")
  let c = col(".")
  silent! execute ':%s/\s\+$//e'
  call cursor(l, c)
endfunc
command! Wsp call g:RemoveTrailingWhitespace()

" splits sentences onto newlines
function! g:SplitSentences()
  silent! execute ':%s/\.\|?/&\r/'
endfunc
command! SplitSentences call g:SplitSentences()

" update vim-plug
command! PU PlugUpdate | PlugUpgrade

" }}}
