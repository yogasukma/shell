sudo apt install git vim fzf

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

tee -a ~/.vimrc << END
set noswapfile
set nocompatible
set nowrap
set expandtab
set re=0
set belloff=all
set laststatus=2
set tabstop=4
set shiftwidth=4
set splitright
set splitbelow
filetype off 
syntax on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'ayu-theme/ayu-vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'neoclide/coc.nvim'
Plugin 'SirVer/ultisnips'
Plugin 'preservim/nerdtree'
Plugin 'StanAngeloff/php.vim'
Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'jwalton512/vim-blade'
Plugin 'pangloss/vim-javascript'
Plugin 'posva/vim-vue'
Plugin 'junegunn/vim-easy-align'
call vundle#end()
filetype plugin indent on

nmap <C-s> :w<CR>
nmap <C-q> :q<CR>
nmap <C-p> :Files<CR>
nmap <C-i> :Tags<CR>
nmap <C-o> :Buffers<CR>
nmap <C-e> :NERDTreeToggle<CR>
nmap <C-Left> :tabn<CR>
nmap <C-Right> :tabp<CR>
nmap <C-t> :tabe<CR>
nmap ga <Plug>(EasyAlign)

autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
END

cd ~/.vim/bundle/coc.nvim
yarn install

cd ~
