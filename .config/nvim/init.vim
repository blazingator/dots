if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/autoload/plugged')
  " Autocompletion
  Plug  'neoclide/coc.nvim', {'branch':'release'}
  Plug  'scrooloose/nerdtree'
  "Plug  'Omnisharp/omnisharp-vim'
  Plug  'pangloss/vim-javascript'
  Plug  'leafgarland/typescript-vim'
  Plug  'peitalin/vim-jsx-typescript'
  Plug  'styled-components/vim-styled-components', {'branch': 'master'}
  Plug	'suan/vim-instant-markdown', { 'for': 'markdown' }

  " Edição
  Plug  'w0rp/ale'
  Plug  'tpope/vim-commentary'
  Plug  'tpope/vim-sleuth'
  Plug  'jiangmiao/auto-pairs'
  "Plug  'chrisbra/colorizer'
  Plug  'norcalli/nvim-colorizer.lua'

  " Estilização
  Plug  'dracula/vim'
  Plug  'chmllr/elrodeo-vim-colorscheme'
  Plug 'ghifarit53/tokyonight-vim'
  Plug  'szorfein/sci.vim'
  Plug	'vim-airline/vim-airline'
  Plug	'vim-airline/vim-airline-themes' 
  Plug  'ryanoasis/vim-devicons'
call plug#end()

" CocSettings
source $HOME/.config/nvim/plug-config/coc.vim

" Airline
source $HOME/.config/nvim/plug-config/airline.vim

" OmniSharp
"source $HOME/.config/nvim/plug-config/omnisharp.vim

" Lua colorizer
set termguicolors
luafile $HOME/.config/nvim/lua/plug-colorizer.lua
"set termguicolors!
"autocmd FileType * ColorHighlight!

" Colorscheme
let g:tokyonight_transparent_background = 1
let g:tokyonight_style = 'night'
colorscheme tokyonight

"Instant Markdown
let g:instant_markdown_autostart = 0

" Keybindings
nmap <space>e :CocCommand explorer<CR>
"nmap <space>e :NERDTreeToggle<CR>
nmap <space>f :CocCommand explorer --preset floating<CR>
nmap <C-s> :w<CR>
"nmap <space>w :ColorHighlight!<CR>
map q :quit<CR>
map <C-q> :quit!<CR>

set laststatus=2
set confirm
set nu!

" Indentação
set tabstop=2
set softtabstop=-1
set shiftwidth=0
set expandtab

" mouse
set mouse=a
