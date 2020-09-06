if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/autoload/plugged')
  Plug  'neoclide/coc.nvim', {'branch':'release'}
  Plug  'scrooloose/nerdtree'
  Plug  'Omnisharp/omnisharp-vim'
  Plug  'w0rp/ale'
  Plug	'vim-airline/vim-airline'
  Plug	'vim-airline/vim-airline-themes'
  Plug	'suan/vim-instant-markdown', { 'for': 'markdown' }
  Plug  'dracula/vim'
  Plug  'pangloss/vim-javascript'
  Plug  'leafgarland/typescript-vim'
  Plug  'peitalin/vim-jsx-typescript'
  Plug  'styled-components/vim-styled-components', {'branch': 'master'}
  Plug  'tpope/vim-commentary'
  Plug  'tpope/vim-sleuth'
  Plug  'jiangmiao/auto-pairs'
  Plug  'ryanoasis/vim-devicons'
  Plug  'chrisbra/colorizer'
call plug#end()

"autocmd VimEnter * NERDTree

" CocSettings
source $HOME/.config/nvim/plug-config/coc.vim
let g:coc_node_path = "/usr/bin/node"
"autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
let g:coc_explorer_global_presets = {
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow'
\   }
\ }
"autocmd VimEnter * CocCommand explorer

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep= ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
autocmd VimEnter * AirlineTheme deus

" OmniSharp
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_path = '/home/vinicius/.omnisharp/omnisharp-linux-x64/run'
source $HOME/.config/nvim/plug-config/omnisharp.vim

" Keybindings
nmap <space>e :CocCommand explorer<CR>
nmap <space>f :CocCommand explorer --preset floating<CR>
  nmap <C-s> :w<CR>
map q :quit<CR>
map <C-q> :quit!<CR>

set confirm
set laststatus=2
set confirm
set nu!

" Indentação
set tabstop=2
set softtabstop=-1
set shiftwidth=0
set expandtab

set mouse=a
