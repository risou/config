let mapleader = ","
map <silent> <leader>ss :source .vimrc<cr>
map <silent> <leader>ee :e .vimrc<cr>
autocmd! bufwritepost .vimrc source .vimrc

" viとの互換性OFF
set nocompatible

" バックアップをOFF
set nobackup

" 検索：大文字と小文字を区別しない
set ignorecase

" 検索：大文字が含まれているときは区別する
set smartcase

" タイトルを表示
set title

" 行番号を表示
set number

" 業番号を印刷
set printoptions=number:y

" tab = 4
set tabstop=4

" indent = 4
set shiftwidth=4

" 対応する括弧を表示
set showmatch

" シンタックスハイライトをON
syntax on

" 検索結果のハイライト
set hlsearch

" オートインデント
"set autoindent

" タブを空白に変更しない
set noexpandtab

" 起動時のメッセージOFF
set shortmess+=I

" カレントディレクトリを自動切り替え
"set autochdir

" BackSpaceでインデントや改行を削除
set backspace=2

" 履歴
set history=300

" ルーラを表示
set ruler

" クリップボードを使用
set clipboard=unnamed

" テキスト挿入中の自動折り返しを日本語に対応
set formatoptions+=mM

" コンパイラの設定
autocmd FileType perl,cgi : compiler perl

" 文字コードの自動判別
set encoding=utf-8
set fileencodings=iso-2022-jp,sjis,euc-jp,cp932,utf-8
" 改行コードの自動判別
set fileformats=unix,mac,dos

" タブ文字を表示
set lcs=tab:>.,eol:$,trail:_,extends:\
set list
" ○や□などの文字でカーソル位置がずれないようにする
if exists('&ambiwidth')
	set ambiwidth=double
endif

" GREPの設定
au QuickfixCmdPost vimgrep cw

" outputz
let g:outputz_secret_key='OyG9uk527SxQ'
let g:outputz_uri='http://www.rs-f.net/'
