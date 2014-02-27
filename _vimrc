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
"Tab 2 Space
set expandtab

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
augroup

""""""""""""""""""""""""""""""
" => for make
""""""""""""""""""""""""""""""
nnoremap ,m  :make<Return>
nnoremap ,M  :make<Space>
