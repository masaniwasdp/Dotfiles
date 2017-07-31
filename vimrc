" 256色表示
set t_Co=256

" 行番号を表示
set number

" シンタックスハイライト
syntax on

" カーソルライン
set cursorline

" 縦線表示
set colorcolumn=120

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

" タグの生成
noremap <C-P> :TagsGenerate<CR>

" ウィンドウの移動
noremap <C-W> <C-W>w

" タブの設定
function! s:SID_PREFIX()
  return matchstr(expand("<sfile>"), "<SNR>\d\+_\zeSID_PREFIX$")
endfunction

function! s:tabline()
    let s = ""

    for i in range(1, tabpagenr("$"))
        let bufnr = tabpagebuflist(i)[tabpagewinnr(i) - 1]

        let mod = getbufvar(bufnr, "&modified") ? "!" : " "
        let title = "[" . fnamemodify(bufname(bufnr), ":t") . "]"

        let s .= "%" . i . "T"
        let s .= "%#" . (i == tabpagenr() ? "TabLineSel" : "TabLine") . "#"
        let s .= i . ":" . title . mod . "%#TabLineFill# "
    endfor

    let s .= "%#TabLineFill#%T%=%#TabLine#"

    return s
endfunction

let &tabline = "%!" . s:SID_PREFIX() . "tabline()"

set showtabline=2

nnoremap [Tag] <Nop>
nmap t [Tag]

for n in range(1, 9)
    execute "nnoremap [Tag]" . n  ":<C-u>tabnext" . n . "<CR>"
endfor

map [Tag]c :tablast <bar> tabnew<CR>
map [Tag]x :tabclose<CR>
map [Tag]n :tabnext<CR>
map [Tag]p :tabprevious<CR>

" プラグイン管理
if has("vim_starting")
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand("~/.vim/bundle/"))

NeoBundleFetch "Shougo/neobundle.vim"

NeoBundle "iamcco/markdown-preview.vim"
NeoBundle "itchyny/lightline.vim"
NeoBundle "jceb/vim-hier"
NeoBundle "majutsushi/tagbar"
NeoBundle "osyo-manga/vim-watchdogs"
NeoBundle "osyo-manga/shabadou.vim"
NeoBundle "thinca/vim-quickrun"
NeoBundle "szw/vim-tags"
NeoBundle "Shougo/neocomplete"
NeoBundle "Shougo/neomru.vim"
NeoBundle "Shougo/neosnippet"
NeoBundle "Shougo/neosnippet-snippets"
NeoBundle "Shougo/unite.vim"
NeoBundle "Shougo/vimfiler"
NeoBundle "Shougo/vimproc.vim", {"build": {"linux": "make"}}
NeoBundle "Yggdroot/indentLine"

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

" unite.vim
let g:unite_source_file_mru_limit = 16

noremap <C-F> :Unite -buffer-name=file file<CR>
noremap <C-H> :Unite file_mru<CR>
noremap <C-C> :UniteWithBufferDir file -buffer-name=file<CR>

" vimfiler
noremap <C-E> :VimFilerExplorer<CR>

" lightline.vim
let g:lightline = {"colorscheme": "solarized"}

" tagbar
noremap <C-L> :TagbarToggle<CR>
noremap <C-K> :TagbarOpenAutoClose<CR>

" vim-quickrun
let g:quickrun_config = {
            \ "_": {
            \   "outputter": "error",
            \   "outputter/error/success": "buffer",
            \   "outputter/error/error": "quickfix",
            \   "outputter/buffer/split": "botright 8sp",
            \   "outputter/quickfix/open_cmd": "copen",
            \   "runner": "vimproc",
            \   "runner/vimproc/updatetime": "100"
            \   },
            \
            \ "c/watchdogs_checker": {"type": "watchdogs_checker/clang"},
            \ "cpp/watchdogs_checker": {"type": "watchdogs_checker/clang++"},
            \ "d/watchdogs_checker": {"type": "watchdogs_checker/dmd"},
            \ "haskell/watchdogs_checker": {"type": "watchdogs_checker/ghc-mod"},
            \ "python/watchdogs_checker": {"type": "watchdogs_checker/flake8"},
            \
            \ "watchdogs_checker/clang": {"cmdopt": "-Wall -Wextra -std=c11 -Iinclude"},
            \ "watchdogs_checker/clang++": {"cmdopt": "-Wall -Wextra -std=c++14 -Iinclude"},
            \ "watchdogs_checker/dmd": {"cmdopt": "-wi -o- `~/DUBImport/build/dubimport`"}
            \ }

let s:hook = {"name": "clear_quickfix", "kind": "hook"}

function! s:hook.on_normalized(session, context)
    call setqflist([])
endfunction

call quickrun#module#register(s:hook, 1)

unlet s:hook

let g:watchdogs_check_BufWritePost_enable = 1

" markdown-preview.vim
let g:mkdp_path_to_chrome = "google-chrome-stable"
