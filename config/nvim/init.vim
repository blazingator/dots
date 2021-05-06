if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/autoload/plugged')
  " Autocompletion
  Plug  'neoclide/coc.nvim', {'branch':'release'}
  Plug  'pangloss/vim-javascript'
  Plug  'leafgarland/typescript-vim'
  Plug  'peitalin/vim-jsx-typescript'
  Plug  'rust-lang/rust.vim'
  Plug  'leafo/moonscript-vim'
  Plug  'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

  " Ferramentas
  Plug  'voldikss/vim-floaterm'
  Plug  'eliba2/vim-node-inspect'

  " Edição
  "Plug  'w0rp/ale'
  "Plug  'vim-syntastic/syntastic'
  Plug  'tpope/vim-commentary'
  Plug  'tpope/vim-sleuth'
  Plug  'jiangmiao/auto-pairs'
  Plug  'mg979/vim-visual-multi', {'branch': 'master'}
  "Plug  'chrisbra/colorizer'
  "Plug  'RRethy/vim-hexokinase'
  Plug  'norcalli/nvim-colorizer.lua'
  Plug  'Yggdroot/indentLine'

  " Estilização
  Plug  'chmllr/elrodeo-vim-colorscheme'
  Plug  'ghifarit53/tokyonight-vim'
  Plug  'kaicataldo/material.vim', { 'branch': 'main' }
  Plug  'szorfein/sci.vim'
  Plug  'vim-airline/vim-airline'
  Plug  'vim-airline/vim-airline-themes'
  Plug  'ryanoasis/vim-devicons'
call plug#end()

" CocSettings
source $HOME/.config/nvim/plug-config/coc.vim

" Airline
source $HOME/.config/nvim/plug-config/airline.vim

" Lua colorizer
set termguicolors
luafile $HOME/.config/nvim/lua/plug-colorizer.lua

"autocmd FileType * ColorHighlight!

" Colorscheme
let g:tokyonight_transparent_background = 1
let g:tokyonight_style = 'storm'
colorscheme tokyonight

"Instant Markdown
let g:mkdp_auto_start = 0

" Keybindings
nmap <space>e :CocCommand explorer<CR>
nmap <space>f :CocCommand explorer --preset floating<CR>
nnoremap <F4> :FloatermToggle --height=0.7 --wintype=floating<CR>
map <C-s> :w<CR>
"nmap <space>w :ColorHighlight!<CR>
nmap q :quit<CR>
map <C-q> :quit!<CR>

set laststatus=2
set confirm
set nu!

" node-inspect
nnoremap <silent><F5> :NodeInspectStart<cr>
nnoremap <silent><F6> :NodeInspectRun<cr>
nnoremap <silent><F7> :NodeInspectConnect("127.0.0.1:9229")<cr>
nnoremap <silent><F8> :NodeInspectStepInto<cr>
nnoremap <silent><F9> :NodeInspectStepOver<cr>
nnoremap <silent><F10> :NodeInspectToggleBreakpoint<cr>
nnoremap <silent><F11> :NodeInspectStop<cr>

" Indentação
set tabstop=2
set softtabstop=-1
set shiftwidth=2
set expandtab

" mouse
set mouse=a
