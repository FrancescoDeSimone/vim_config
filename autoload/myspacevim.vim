function! myspacevim#after() abort
    set expandtab
    set tabstop=4
    set cc=80
    set termguicolors
    set incsearch
    set hlsearch
    set foldenable
    set foldlevelstart=10
    set lazyredraw
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
endfunction
