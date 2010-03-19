let mapleader = ","
if has('macunix') "Mac OS X
elseif has('unix') "Unix
elseif has('win32') "Windows
    "vimrc編集
    map <silent> <leader>ss :source $VIM/_vimrc<cr>
    map <silent> <leader>ee :e $VIM/_vimrc<cr>
    autocmd! bufwritepost _vimrc source $VIM/_vimrc
endif

let g:NeoComplCache_EnableAtStartUp = 1

"検索履歴
set history=300 

"tab幅の設定
set shiftwidth=4
set tabstop=4
"Tab 2 Space
set expandtab

"オートインデント設定
set cindent

"クリップボード使用
set clipboard=unnamed

"行番号表示
set number

"行番号印刷
set printoptions=number:y

"ルーラを表示
set ruler

"起動時のメッセージを表示しない
set shortmess+=I

"バックアップファイルはいらない
set nobackup

"GREPの設定
au QuickfixCmdPost vimgrep cw

"カレントディレクトリを、現在開いているファイルのディレクトリにする
au BufEnter * execute ":lcd " . expand("%:p:h")

"Outputz for vim
let g:outputz_secret_key = 'OyG9uk527SxQ'
let g:outputz_uri = 'http://www.rs-f.net/'

filetype on
filetype indent on
filetype plugin on
""""""""""""""""""""""""""""""
" => for ruby
""""""""""""""""""""""""""""""
augroup AuForRuby
    autocmd!
    autocmd FileType ruby,eruby setlocal tabstop=2
    autocmd FileType ruby,eruby setlocal shiftwidth=2
    autocmd FileType ruby,eruby setlocal expandtab
    " for error marker
    autocmd FileType ruby,eruby setlocal makeprg=ruby\ -cdw\ %
    autocmd FileType ruby,eruby setlocal errorformat=%f:%l:%m
    "au BufWritePost <buffer> silent make
augroup

""""""""""""""""""""""""""""""
" => for make
""""""""""""""""""""""""""""""
nnoremap ,m  :make<Return>
nnoremap ,M  :make<Space>
