let mapleader = ","
if has('macunix') "Mac OS X
elseif has('unix') "Unix
elseif has('win32') "Windows
    "vimrc�ҏW
    map <leader>ss :source $VIM/_vimrc<cr>
    map <leader>ee :e $VIM/_vimrc<cr>
    autocmd! bufwritepost _vimrc source $VIM/_vimrc
endif

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

"Outputz for vim
let g:outputz_secret_key = 'OyG9uk527SxQ'
let g:outputz_uri = 'http://www.rs-f.net/'
