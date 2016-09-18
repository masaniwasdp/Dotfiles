" Ctrl+Zで落ちないようにする
noremap <C-Z> <CR>

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

" バックアップをとらない
set nobackup

" タブやスペースの可視化
set list
set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%

" 自動的に閉じ括弧を入力
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

" デフォルトのエンコーディング
set encoding=utf-8
set fileencodings=utf-8,sjis,euc-jp
set fileformats=unix,dos,mac

" ステータスラインを常時表示
set laststatus=2

" -- タブの設定 --
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

" The prefix key.
nnoremap [Tag] <Nop>

" Tab jump
nmap t [Tag]

" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tc 新しいタブを一番右に作る
map <silent> [Tag]c :tablast <bar> tabnew<CR>

" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>

" tn 次のタブ
map <silent> [Tag]n :tabnext<CR>

" tp 前のタブ
map <silent> [Tag]p :tabprevious<CR>

" -- タブの設定終わり --

" -- NeoBundle Scripts --
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" ファイルオープンを便利にする
NeoBundle 'Shougo/unite.vim'

" Unite.vimで最近使ったファイルを表示できるようにする
NeoBundle 'Shougo/neomru.vim'

" ファイルをtree表示
NeoBundle 'scrooloose/nerdtree'
noremap <C-E> :NERDTreeToggle<CR>

" 詳細なステータスライン
NeoBundle 'itchyny/lightline.vim'
let g:lightline = {'colorscheme': 'solarized'}

" 入力補完
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

" Taglist
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'szw/vim-tags'
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_Show_One_File = 0
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
map <C-L> :TlistToggle<CR>

" -- Unite.vimの設定 --

" 最近開いたファイル履歴の保存数
let g:unite_source_file_mru_limit = 16

" ファイル一覧
noremap <C-F> :Unite -buffer-name=file file<CR>

" 最近使ったファイル一覧
noremap <C-H> :Unite file_mru<CR>

" 今開いているディレクトリのファイル一覧
noremap <C-C> :UniteWithBufferDir file -buffer-name=file<CR>

" -- Unite.vimの設定終わり --

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" -- End NeoBundle Scripts --
