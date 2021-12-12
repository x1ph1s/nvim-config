" Small latex integration

function! s:BuildLatex()
	if &filetype !=# 'tex'
		echom "[Latex]: " . expand('%') . " not a latex file"
		return
	endif

	let latex_dir = expand('%:h') . '/.latex_' . expand('%:t:r')
	call mkdir(latex_dir, "p")

	execute '!pdflatex -output-directory ' . latex_dir ' ' . expand('%')

	let pdf_file = latex_dir . '/' . expand('%:r') . '.pdf'
	execute 'silent !mv ' . pdf_file . ' .'
endfunction

nnoremap <leader>bl :call <SID>BuildLatex()<cr>
