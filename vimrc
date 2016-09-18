" 256色表示
set t_Co=256

" 行番号を表示
set number

" シンタックスハイライト
syntax on

" カーソルライン
set cursorline

hi clear CursorLine
highlight CursorLine ctermbg=white

" タブをスペース4つに置換
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

" タブやスペースの可視化
set list
set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%

" バックアップをとらない
set nobackup

" デフォルトのエンコーディング
set encoding=utf-8
set fileencodings=utf-8,sjis,euc-jp
set fileformats=unix,dos,mac

" ステータスラインを常時表示
set laststatus=2

" UndoとRedo
noremap <C-Z> u
noremap <C-Y> <C-R>

" タブの設定
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! s:my_tabline()
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction

let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2

nnoremap [Tag] <Nop>
nmap t [Tag]

for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]x :tabclose<CR>
map <silent> [Tag]n :tabnext<CR>
map <silent> [Tag]p :tabprevious<CR>

" プラグイン管理
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'szw/vim-tags'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" unite.vimの設定
let g:unite_source_file_mru_limit = 16

noremap <C-F> :Unite -buffer-name=file file<CR>
noremap <C-H> :Unite file_mru<CR>
noremap <C-C> :UniteWithBufferDir file -buffer-name=file<CR>

" nerdtreeの設定
noremap <C-E> :NERDTreeToggle<CR>

" lightline.vimの設定
let g:lightline = {'colorscheme': 'solarized'}

" taglist.vimの設定
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1

map <C-L> :TlistToggle<CR>
