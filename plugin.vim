"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
let g:python3_host_prog="/usr/bin/python3"
let g:python_host_prog="/usr/bin/python2"
set runtimepath+=~/.dein/repos/github.com/Shougo/dein.vim

call dein#begin('~/.dein')

" Let dein manage dein
" Required:
call dein#add('~/.dein/repos/github.com/Shougo/dein.vim')

call dein#add('neovim/nvim-lspconfig')
call dein#add('williamboman/nvim-lsp-installer')
call dein#add('glepnir/lspsaga.nvim')
call dein#add('ms-jpq/coq_nvim', {'rev': 'coq', 'build': 'python3 -m coq deps'})
call dein#add('ms-jpq/coq.artifacts', {'rev': 'artifacts'})
call dein#add('ms-jpq/coq.thirdparty', {'rev': '3p'})
call dein#add('Yggdroot/indentLine')
call dein#add('editorconfig/editorconfig-vim')
call dein#add('ConradIrwin/vim-bracketed-paste')
call dein#add('scrooloose/nerdcommenter')
call dein#add('jlanzarotta/bufexplorer')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('ms-jpq/chadtree', {'rev': 'chad', 'build': 'python3 -m chadtree deps'})
call dein#add('tpope/vim-surround')
call dein#add('ray-x/aurora')
call dein#add('itchyny/lightline.vim')
call dein#add('Shougo/echodoc.vim')
call dein#add('w0rp/ale')
call dein#add('jiangmiao/auto-pairs')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------

" let g:vim_markdown_conceal = 0
" let g:vim_markdown_conceal_code_blocks = 0

"indentLine
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = "nv"

" python
let g:python_highlight_all = 1

" CHADtree
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | CHADopen
nnoremap <leader>v <cmd>CHADopen<cr>

" theme
set termguicolors            " 24 bit color
colorscheme aurora

" deoplete
let g:deoplete#enable_at_startup = 1

autocmd CompleteDone * pclose!
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<BS>"
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" echodoc
let g:echodoc#enable_at_startup = 1

" ale
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'active': {
      \   'left': [
      \             ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'modified'],
      \             ['filename']
      \           ],
      \   'right': [
      \              ['filetype', 'fileencoding', 'fileformat'],
      \              ['lineinfo', 'percent'],
      \              [ 'linter' ]
      \            ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_function': {
      \   'linter': 'LinterStatus'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
    \ }

let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"

" nerdcommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

let g:coq_settings = { 'auto_start': v:true }

