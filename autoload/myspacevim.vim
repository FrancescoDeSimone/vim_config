function! myspacevim#before() abort
	set cc=80
endfunction

function! myspacevim#after() abort
	UpdateRemotePlugins
endfunction
