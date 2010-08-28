let mapleader = ","
if has('macunix') "Mac OS X
elseif has('unix') "Unix
elseif has('win32') "Windows
    "vimrc�ҏW
    map <silent> <leader>ss :source $VIM/_vimrc<cr>
    map <silent> <leader>ee :e $VIM/_vimrc<cr>
    autocmd! bufwritepost _vimrc source $VIM/_vimrc
endif

let g:NeoComplCache_EnableAtStartUp = 1

"��������
set history=300 

"tab���̐ݒ�
set shiftwidth=4
set tabstop=4
"Tab -> Space
"set expandtab

"�I�[�g�C���f���g�ݒ�
set cindent

"�N���b�v�{�[�h�g�p
set clipboard=unnamed

"�s�ԍ��\��
set number

"�s�ԍ����
set printoptions=number:y

"���[����\��
set ruler

"�N�����̃��b�Z�[�W��\�����Ȃ�
set shortmess+=I

"�o�b�N�A�b�v�t�@�C���͂���Ȃ�
set nobackup

"�^�u������\��
set lcs=tab:>.,eol:$,trail:_,extends:\
set list

"�����R�[�h�̎�������
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,cp932,utf-8
"���s�R�[�h�̎����F��
set fileformats=unix,dos,mac

"���⁠�Ȃǂ̕����ŃJ�[�\���ʒu������Ȃ��悤�ɂ���
if exists('&ambiwidth')
	set ambiwidth=double
endif

"�S�p�X�y�[�X��\��
augroup JpSpaceHook
autocmd!
autocmd Colorscheme * highlight JpSpace cterm=underline ctermbg=lightblue guibg=lightblue
autocmd VimEnter,WinEnter * match JpSpace /�@/
augroup END

"���̓��[�h���A�X�e�[�^�X���C���̃J���[��ύX
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#FFFFFF guibg=#FE1235
autocmd InsertLeave * highlight StatusLine guifg=#0000FF guibg=#FFFFFF
augroup END

"GREP�̐ݒ�
au QuickfixCmdPost vimgrep cw

"�J�����g�f�B���N�g�����A���݊J���Ă���t�@�C���̃f�B���N�g���ɂ���
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
augroup END

""""""""""""""""""""""""""""""
" => for make
""""""""""""""""""""""""""""""
nnoremap ,m  :make<Return>
nnoremap ,M  :make<Space>

