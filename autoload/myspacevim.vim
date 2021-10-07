function! myspacevim#after() abort
    set expandtab
    set tabstop=4
    set cc=80
    set termguicolors
    set incsearch
    set hlsearch
    set foldlevelstart=10
    set showbreak=<--
    set smartindent
    set smartcase
    set noswapfile
    set nocursorcolumn
    set nocursorline
    set scrolljump=3      
    set showmatch
    set nocursorcolumn
    set wildignorecase
    set linebreak
    set wrap
    set nocursorline
    set nowritebackup
    set norelativenumber
    set ttyfast
    set synmaxcol=80
    set redrawtime=10000
    autocmd BufEnter * :syn sync maxlines=500
    let mapleader=","
    set shiftwidth=4
    set splitright
    set nocompatible
    filetype plugin indent on
    set foldenable
    set foldmethod=marker
    set foldmethod=indent
    let g:coc_global_extensions = ['coc-prettier','coc-clangd','coc-cmake','coc-css','coc-cssmodules','coc-deno','coc-calc','coc-browser','coc-explorer','coc-dot-complete','coc-diagnostic','coc-eslint','coc-flutter','coc-git','coc-graphql','coc-java','coc-jedi','coc-json','coc-just-complete','coc-markdownlint','coc-markdown-preview-enhanced','coc-rls','coc-rome','coc-rust-analyzer','coc-sh','coc-snippets','coc-tabnine','coc-tsserver','coc-toml','coc-xml','coc-yaml','coc-webview','coc-translator','coc-texlab']
    nnoremap sq :q<CR>
    nnoremap wq :bd<CR>
endfunction

function! myspacevim#before() abort
endfunction
