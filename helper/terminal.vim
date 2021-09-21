" Terminal opening and closing functionality

function! s:GetTerminalWindow()
"	let buffers = filter(map(nvim_list_wins(), {index,window -> nvim_win_get_buf(window)}), {index,buffer -> getbufvar(buffer, '&buftype') ==# 'terminal'})
	let windows = nvim_list_wins()
	for win in windows
		if getwinvar(nvim_win_get_number(win), '&buftype') ==# 'terminal'
			return win
		endif
	endfor

	return -1
endfunction

function! s:OpenTerminal()
	let terminal = <SID>GetTerminalWindow()
	if terminal < 0
		new
		wincmd J
		resize 10
		terminal
		startinsert
	else
		call win_gotoid(terminal)
		startinsert
	endif
endfunction

function! s:CloseTerminal()
	if &buftype !=# 'terminal'
		let previous_window = win_getid()

		let terminal_window = <SID>GetTerminalWindow()
		if terminal_window < 0
			return
		endif
		call nvim_win_close(terminal_window, 0)
	else
		let previous_window = win_getid(winnr('#'))
		call nvim_win_close(0, 0)
	endif

	call win_gotoid(previous_window)
endfunction

augroup terminal
	autocmd!
	autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

nnoremap <leader>en :call <SID>OpenTerminal()<cr>
tnoremap <leader>ew <c-\><c-n><c-w>w
nnoremap <leader>eq <c-w>:call <SID>CloseTerminal()<cr>
tnoremap <leader>eq <c-\><c-n>:call <SID>CloseTerminal()<cr>
