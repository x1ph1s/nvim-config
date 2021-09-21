" Better window changing
" Exclude terminal windows

function! s:NextWindow(movement, count, max_count)
	if a:movement ==# 'w'
		let next_window = winnr() + a:count
		if next_window <= a:max_count
			return next_window
		else
			return next_window - a:max_count
		endif
	else
		return winnr(a:count . a:movement)
	endif
endfunction

function! s:ChangeWindow(movement)
	let max_count = winnr('$')
	let l:count = 1
	let window = <SID>NextWindow(a:movement, l:count, max_count)

	while getwinvar(window, '&buftype') ==# 'terminal'
		if count - 1 >= max_count
			return
		endif

		let l:count = l:count + 1
		let window = <SID>NextWindow(a:movement, l:count, max_count)
	endwhile
	execute window . 'wincmd w'
endfunction

nnoremap <leader>w :call <SID>ChangeWindow('w')<cr>
nnoremap <leader>h :call <SID>ChangeWindow('h')<cr>
nnoremap <leader>j :call <SID>ChangeWindow('j')<cr>
nnoremap <leader>k :call <SID>ChangeWindow('k')<cr>
nnoremap <leader>l :call <SID>ChangeWindow('l')<cr>
