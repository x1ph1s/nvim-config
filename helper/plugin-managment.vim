" Simple plugin managment functionality

function! s:UpdateSubRepos()
	let command = 'git submodule foreach git pull --depth 1 origin'

	let return_window = win_getid()

	keepalt leftabove vertical new
	wincmd H
	vertical resize 30
	call termopen(command)

	call win_gotoid(return_window)
endfunction

command! PluginUpdate call <SID>UpdateSubRepos()
