"viとの互換モードをOFF
set nocompatible

let mapleader = ","
if has('macunix') "Mac OS X
elseif has('unix') "Unix
elseif has('win32') "Windows
    "vimrc編集
    map <silent> <leader>ss :source $VIM/_vimrc<cr>
    map <silent> <leader>ee :e $VIM/_vimrc<cr>
    autocmd! bufwritepost _vimrc source $VIM/_vimrc
endif

"pathogen.vim
call pathogen#runtime_append_all_bundles()

"検索履歴
set history=300 

"tab幅の設定
set shiftwidth=4
set tabstop=4
"Tab -> Space
"set expandtab

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

"コマンドライン補完の拡張
set wildmenu
"バッファが隠れる際にアンロードしない
set hid
"コマンドをステータス行に表示
set showcmd
"バックスペースで削除できるものっを指定
set backspace=indent,eol,start
"対応する括弧を表示
set showmatch
"エラー時のベルを無効
set noerrorbells
set novisualbell
set t_vb=

"gvimの設定
set guioptions-=T "メニューアイコンの除去

"escでハイライトをオフ
nnoremap <silent> <ESC> <ESC>:noh<CR>

"ステータスラインに情報を表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"window分割の際の挙動変更
set splitbelow
set splitright

"ファイルタイプ識別
filetype plugin indent on

"オムニ補完のキー変更
imap <C-Space> <C-x><C-o>

"タブ文字を表示
set lcs=tab:>.,eol:$,trail:_,extends:\
set list

"文字コードの自動判別
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,cp932,utf-8
"改行コードの自動認識
set fileformats=unix,dos,mac

"○や□などの文字でカーソル位置がずれないようにする
if exists('&ambiwidth')
    set ambiwidth=double
endif

"全角スペースを表示
augroup JpSpaceHook
autocmd!
autocmd Colorscheme * highlight JpSpace cterm=underline ctermbg=lightblue guibg=lightblue
autocmd VimEnter,WinEnter * match JpSpace /　/
augroup END

"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#FFFFFF guibg=#FE1235
autocmd InsertLeave * highlight StatusLine guifg=#0000FF guibg=#FFFFFF
augroup END

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
    "環境固有の設定 #works_notebook
	autocmd FileType ruby,eruby set tags+=C:\fcube-app\VEE\ruby\tags
	autocmd FileType ruby,eruby set tags+=C:\Ruby\tags
    "au BufWritePost <buffer> silent make
augroup END

""""""""""""""""""""""""""""""
" => for python
""""""""""""""""""""""""""""""
augroup AuForPython
	autocmd!
	autocmd FileType python setlocal tabstop=8
	autocmd FileType python setlocal shiftwidth=4
	autocmd FileType python setlocal noexpandtab
	autocmd FileType python setlocal softtabstop=4
	autocmd FileType python setlocal smartindent
	autocmd FileType python setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
augroup END

""""""""""""""""""""""""""""""
" => for make
""""""""""""""""""""""""""""""
nnoremap ,m  :make<Return>
nnoremap ,M  :make<Space>

""""""""""""""""""""""""""""""
"ジャンプの設定 #taglist.vim
""""""""""""""""""""""""""""""
"tを解除
nnoremap t <Nop>
"ジャンプ
nnoremap tt <C-]>
"ジャンプ履歴/進む
"ジャンプ履歴/戻る
nnoremap tj :<C-u>tag<CR>
nnoremap tk :<C-u>pop<CR>
:set tags=tags
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1

""""""""""""""""""""""""""""""
"newcomplcacheの設定
""""""""""""""""""""""""""""""
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . (&indentexpr != '' ? "\<C-f>\<CR>X\<BS>":"\<CR>")
inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
