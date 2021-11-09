" Simple plugin managment functionality

function! s:UpdateSubRepos()
	let command = 'git submodule foreach "git fetch --depth=1 origin && git reset --hard origin/HEAD && git clean -dfx"'

	let return_window = win_getid()

	keepalt leftabove vertical new
	wincmd H
	vertical resize 30
	call termopen(command)

	execute 'Helptags'

	call win_gotoid(return_window)
endfunction

command! PluginUpdate call <SID>UpdateSubRepos()
