call plug#begin()

"Convenience
Plug 'ntpeters/vim-better-whitespace'
Plug 'Yggdroot/indentLine'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Ansible
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'yaegassy/coc-ansible', {'do': 'yarn install --frozen-lockfile'}
Plug 'pearofducks/ansible-vim'


"Git
Plug 'tpope/vim-fugitive'
call plug#end()

"coc ansible language server config
let g:coc_global_exentensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-ansible',
  \ 'coc-prettier',
  \ ]
let g:coc_filetype_map = {
  \ 'yaml.ansible': 'ansible',
  \ }

"Ansible-vim config
augroup filetype_ansible
  autocmd!
  autocmd BufNewFile,BufRead,FileReadPre *.yaml,*.yml set filetype=yaml.ansible
augroup END
autocmd FileType yaml.ansible syntax enable
let g:ansible_attribute_highlight = "ab"
let g:ansible_name_highlight = 'b'
let g:ansible_extra_keywords_highlight = 1
let g:ansible_extra_keywords_highlight_group = 'Statement'
let g:ansible_fqcn_highlight = 'Constant'
let g:ansible_normal_keywords_highlight = 'Constant'
let g:ansible_loop_keywords_highlight = 'Constant'

"Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="wombat"

"NERDTree settings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
"autocmd VimEnter * NERDTree - this will open nerdtree along with the file
let NERDTreeShowHidden=1

"Set numbers
set number
set relativenumber

"" Encoding
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs for yaml syntax
set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab

"" Enable hidden buffers
set hidden

"" Searching
set nohlsearch
set incsearch
set ignorecase
set smartcase

"scroll stop
set scrolloff=8

" lines for formatting
set ruler
set listchars=tab:\|\
set list lcs=tab:\|\
set list


let no_buffers_menu=1
set noswapfile
set nobackup

"Color settings
syntax on
colorscheme default
set background=light
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" mouse support
set mouse=a

set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10

"" Clipboard
set clipboard=unnamedplus

let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
        augroup WSLYank
                    autocmd!
                            autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
                                augroup END
                            endif

        au BufNewFile,BufRead *.tex
            \ set nocursorline |
            \ set nornu |
            \ set number |
            \ let g:loaded_matchparen=1 |
set fileformats=unix,dos,mac


