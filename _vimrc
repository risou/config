let mapleader = ","
if has('macunix') "Mac OS X
elseif has('unix') "Unix
elseif has('win32') "Windows
    "vimrc編集
    map <leader>ss :source $VIM/_vimrc<cr>
    map <leader>ee :e $VIM/_vimrc<cr>
    autocmd! bufwritepost _vimrc source $VIM/_vimrc
endif

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

"Outputz for vim
let g:outputz_secret_key = 'OyG9uk527SxQ'
let g:outputz_uri = 'http://www.rs-f.net/'
