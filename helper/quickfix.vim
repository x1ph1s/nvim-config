" Simple quickfix helper functionality

nnoremap <leader>q :call <SID>QuickfixToggle()<cr>

function! s:QuickFixIsOpen()
	let windows = nvim_list_wins()
	for win in windows
		if getwinvar(nvim_win_get_number(win), '&buftype') ==# 'quickfix'
			return 1
		endif
	endfor

	return 0
endfunction

function! s:QuickfixToggle()
	if <SID>QuickFixIsOpen()
		cclose
	else
		let previous_window = win_getid()
		copen
		wincmd J
		call win_gotoid(previous_window)
	endif
endfunction

function! SetQuickfixFiles(pattern)
	let flist = split(globpath('.', a:pattern), '\n')

	let qf_list = []
	for file in flist
		let dic = {'filename' : file, 'lnum': 1}
		call add(qf_list, dic)
	endfor

	call setqflist(qf_list)
endfunction
