let mapleader = ","
map <silent> <leader>ss :source ~/.vimrc<cr>
map <silent> <leader>ee :e ~/.vimrc<cr>
autocmd! bufwritepost ~/.vimrc source ~/.vimrc

" viとの互換性OFF
set nocompatible

" pathogen.vim
call pathogen#runtime_append_all_bundles()

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

" 行番号を印刷
set printoptions=number:y

" tab = 4
set tabstop=4

" indent = 4
set shiftwidth=4

" 対応する括弧を表示
set showmatch

" シンタックスハイライトをON
syntax on

" 色設定
colorscheme koehler
if &term =~ "xterm-256color" || "screen-256color"
  " 256色
  set t_Co=256
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-color"
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

" カーソル行をハイライト
set cursorline

" コメント色を水色にする
highlight Comment ctermfg=lightcyan
" スペシャルキー色を水色にする
highlight SpecialKey ctermfg=lightcyan
" ノンテキスト色を水色にする
highlight NonText ctermfg=darkcyan
" ディレクトリ色を水色にする
highlight Directory ctermfg=lightcyan

" 検索結果のハイライト
set hlsearch

" オートインデント
"set autoindent
set cindent

" クリップボード使用
set clipboard+=unnamed

" タブを空白に変更しない
set noexpandtab

" 起動時のメッセージOFF
set shortmess+=I

" カレントディレクトリを自動切り替え
"set autochdir

" コマンドライン補完の拡張
set wildmenu

" バッファが隠れる際にアンロードしない
set hid

" コマンドをステータス行に表示
set showcmd

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

" エラー時のベルを無効
set noerrorbells
set novisualbell
set t_vb=

" escでハイライトをオフ
nnoremap <silent> <ESC> <ESC>:noh<CR>

" netrwの設定
let g:netrw_liststyle = 3
let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'
let g:netrw_altv = 1
let g:netrw_alto = 1

" gvimの設定
set guioptions-=T

" ステータスラインに情報を表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

" window分割の際の挙動変更
set splitbelow
set splitright

" ファイルタイプ識別
filetype plugin indent on

" Omni補完の設定
:filetype plugin indent on
"imap <C-Space> <C-x><C-o>
imap <Nul> <C-x><C-o>

" コンパイラの設定
autocmd FileType perl,cgi : compiler perl

" 文字コードの自動判別
set encoding=utf-8
set fileencodings=iso-2022-jp,sjis,euc-jp,cp932,utf-8
" 改行コードの自動判別
set fileformats=unix,mac,dos

" タブ文字を表示
set lcs=tab:>\ ,trail:_,extends:\
"set lcs=tab:>.,eol:$,trail:_,extends:\
set list
" ○や□などの文字でカーソル位置がずれないようにする
if exists('&ambiwidth')
	set ambiwidth=double
endif

" GREPの設定
au QuickfixCmdPost vimgrep cw

" カレントディレクトリを現在開いているファイルのディレクトリにする
au BufEnter * execute ":lcd " . expand("%:p:h")

" NERDTree
let NERDTreeShowHidden = 1
let file_name = expand("%:p")
if has('vim_starting') && file_name == ""
	autocmd VimEnter * execute 'NERDTree ./'
endif

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

