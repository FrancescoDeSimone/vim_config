function! myspacevim#before() abort
    let g:neomake_c_enabled_makers = ['clang']
    nnoremap jk <Esc>
endfunction

function! myspacevim#after() abort
    iunmap jk
endfunction
