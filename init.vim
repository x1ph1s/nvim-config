" ========================================
" Vim configuration {{{
" ========================================
" Interface Options
set encoding=utf-8
set fileformats=unix,dos,mac
set shell=$SHELL
set title
set titlestring=nvim
set termguicolors
set guifont=Fira\ Mono:h12
" User Interface Options
set number relativenumber
set nocursorline
set laststatus=2
set showtabline=1
set noshowmode
set mouse=nvc
set noerrorbells
set belloff=all
set nowrap
set sidescroll=1
set sidescrolloff=10
set scrolloff=1
" Indention
filetype indent on
set autoindent
set noexpandtab
set tabstop=3
set softtabstop=0
set shiftround
let &shiftwidth=&tabstop
" Search Options
set nohlsearch
set incsearch
set ignorecase
set smartcase
" Files
filetype plugin on
set autoread
set autowrite
set confirm
set hidden
set shada=
" Splits
set splitbelow
set splitright
" Miscellaneous
autocmd Filetype * set formatoptions-=c formatoptions-=r formatoptions-=o formatoptions-=j
set noswapfile
set nobackup
set nowritebackup
set nomodeline
set modelines=0
set timeout ttimeout
set timeoutlen=500
set ttimeoutlen=50
set textwidth=0
set wildmenu
set wildmode=full
set makeprg=make
set virtualedit=block
set foldmethod=manual
set foldlevelstart=0
set history=500
" Errorformat
set errorformat=
" Prefile
set errorformat+=%E/usr/bin/ld:\ %.%#:\ in\ function\ %.%#:
set errorformat+=%AIn\ file\ included\ from\ %f:%.%#:
set errorformat+=%A%f:\ In\ function\ %.%#:
set errorformat+=%C%.%#:%l:%c:\ fatal\ %trror:\ %m
set errorformat+=%C%.%#:%l:%c:\ %trror:\ %m
set errorformat+=%C%.%#:%l:%c:\ %tarning:\ %m
set errorformat+=%C%.%#:%l:%c:\ %tnfo:\ %m
set errorformat+=%C%.%#:%l:%c:\ %tote:\ %m
set errorformat+=%C%f:%l:\ %m
" Normal
set errorformat+=%A%f:%l:%c:\ fatal\ %trror:\ %m
set errorformat+=%A%f:%l:%c:\ %trror:\ %m
set errorformat+=%A%f:%l:%c:\ %tarning:\ %m
set errorformat+=%A%f:%l:%c:\ %tnfo:\ %m
set errorformat+=%A%f:%l:%c:\ %tote:\ %m
" Continuation
set errorformat+=%Z%.%#\|%.%#^%.%#
set errorformat+=%Zcollect2:\ error:\ ld\ returned\ %.%#\ exit\ status
set errorformat+=%C%.%#
" Ignore
set errorformat+=%-Gmake%.%#:\ ***\ %.%#\ Error%.%#
" }}}

" ========================================
" Mappings {{{
" ========================================
let mapleader = ' '
let maplocalleader = ' '

" Vim Remappings
inoremap jk <esc>
noremap <space> <nop>

noremap H 0
noremap L $
vnoremap L g_
vnoremap H 0

nnoremap Y y$
nnoremap <leader>0p "0p
noremap <leader>p "+p
noremap <leader>y "+y

" Windows
nnoremap <leader>o <c-w>o:tabonly<cr>
nnoremap <leader>= <c-w>=
nnoremap <leader>r <c-w>r

" Mappings
nnoremap <leader>mw :match Error /\v^ +/<cr>
nnoremap <leader>cm :match none<cr>

nnoremap <leader>sh :setlocal hlsearch!<cr>

nnoremap <leader>cn :cnext<cr>
nnoremap <leader>cp :cprevious<cr>

" Files
nnoremap <leader>tt :tabedit<cr>
nnoremap <leader>tq :tabclose<cr>
nnoremap <leader>th :tabprevious<cr>
nnoremap <leader>tl :tabnext<cr>

" Miscellaneous
vnoremap J :m '>+1<cr>gv
vnoremap K :m '<-2<cr>gv
" }}}

" ========================================
" File specific configuration {{{
" ========================================
" cpp
function! GoCpp()
	inoremap <c-j> {<cr>}<esc>O

	setlocal foldmethod=marker
	setlocal foldmarker=#pragma\ region,#pragma\ endregion
endfunction

augroup filetype_cpp
	autocmd!
	autocmd FileType cpp call GoCpp()
augroup END

" rest
augroup filetype
	autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType qf nnoremap <buffer> <cr> :.cc<cr>
	autocmd FileType text setlocal textwidth=70
	autocmd FileType tex setlocal textwidth=70
	autocmd FileType xml setlocal foldmethod=indent
augroup END

" }}}

" ========================================
" Plugins {{{
" ========================================
execute pathogen#infect()

" gruvbox {{{
syntax enable
set background=dark
let g:gruvbox_contrast_dark = 'soft'
colorscheme gruvbox
" }}}

" lightline {{{
let lightline = {
\	'colorscheme': 'gruvbox',
\	'component': {
\		'filetype': '%{&ft!=#""?&ft:"-"}',
\		'lineinfo': '%1l/%-3L',
\		'relativepath': '%{empty(expand("%")) ? "" : "./" . expand("%")}',
\		'fileinfo': '%{&readonly ? " " : ""}' . '%{expand("%:t")}' . '%{&modified ? "[+]" : ""}'
\	},
\	'active': {
\	 	'left': [
\			['mode', 'paste'],
\			['fileinfo']
\		],
\		'right': [
\			['lineinfo'],
\			['percent'],
\			['relativepath', 'filetype']
\		]
\	},
\	'inactive': {
\		'left': [[ 'relativepath' ]],
\		'right': [ ]
\	},
\	'tabline': {
\		'left': [[ 'tabs' ]],
\		'right': []
\	}
\}
" }}}

" nnn.vim {{{
let g:nnn#set_default_mappings = 0
let g:nnn#replace_netrw = 1
let g:nnn#statusline = 0

let g:nnn#layout = { 'left': '~30%' }
let g:nnn#command = 'nnn -e'

nnoremap <leader>F :NnnPicker<cr>
augroup filetype_nnn
	autocmd!
	autocmd Filetype nnn tnoremap <buffer> l <cr>
augroup END
" }}}

" fzf {{{
let g:fzf_layout = { 'window': '10new' }

nnoremap <leader>f :FZF<cr>
" }}}

" alpha-nvim {{{
function! ChangeDirectory(arg)
	if type(a:arg)  == v:t_list
		let directory = a:arg[0]
	else
		let directory = a:arg
	endif

	execute 'cd ' . directory
	call fzf#run(fzf#wrap({'window': 'enew'}))
endfunction
function! FzfChangeDirectory()
	call fzf#run({"sink": funcref("ChangeDirectory"), "source": "find . -path \"*/.*\" -prune -o -type d -print"})
endfunction

lua << EOF
local session_dir = "~/.vim/session"
vim.cmd("command -nargs=1 Mksession mksession " .. session_dir .. "/<args>")
vim.cmd("command -nargs=1 Rmsession call delete(expand('" .. session_dir .. "/<args>'))")

if vim.fn.exists("g:start_from_keybind") == 1 then
	local header_text = {
		[[                                  __                ]],
		[[     ___     ___    ___   __  __ /\_\    ___ ___    ]],
		[[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
		[[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
		[[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
		[[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
	}
	local bookmark_list = {{"c", "~/.config/nvim/init.vim"}}
	local command_list = {{"e", "<empty buffer>", "enew"}, {"f", "<fzf>", "call FzfChangeDir()"}, {"q", "<quit>", "quit"}}
	require'alpha'.setup(require'alpha_theme'.opts(header_text, bookmark_list, command_list, session_dir))
end
EOF
" }}}

" lsp_signature {{{
lua << EOF
require'lsp_signature'.setup({
	bind = true,
	doc_lines = 0,
	fix_pos = false,
	auto_close_after = nil,
	floating_window = true,
	floating_window_above_cur_line = true,
	hint_enable = false,
	handler_opts = {
		border = "single"
	},
	shadow_blend = 0,
	toggle_key = '<c-t>'
})
EOF
" }}}

" nvim-cmp {{{
set completeopt=menuone,noselect
lua << EOF
local cmp = require'cmp'
local snippy = require'snippy'
cmp.setup({
	snippet = {
		expand = function(args)
			snippy.expand_snippet(args.body)
		end
	},
	mapping = {
		['<c-n>'] = cmp.mapping.select_next_item(),
		['<c-p>'] = cmp.mapping.select_prev_item(),
		['<c-e>'] = cmp.mapping.close(),
		['<cr>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true
		}
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'path' },
		{ name = 'snippy' }
	}
})
EOF
" }}}

" nvim-snippy {{{
lua << EOF
local snippy = require("snippy")
snippy.setup({
    mappings = {
        nis = {
            ["<Tab>"] = "expand_or_advance",
            ["<S-Tab>"] = "previous",
        }
    }
})
EOF
" }}}

" nvim-lspconfig {{{
lua << EOF
local on_attach = function(client)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	local opts = {noremap=true, silent=true}

	buf_set_keymap('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
	buf_set_keymap('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
	buf_set_keymap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
	buf_set_keymap('n', '<leader>sf', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
	buf_set_keymap('n', '<leader>sd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})<cr>', opts)
	buf_set_keymap('n', '<leader>sD', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		signs = true,
		virtual_text = true,
		underline = false,
		update_in_insert = false
	}
)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)

require'lspconfig'.ccls.setup{
	on_attach = on_attach, capabilities = capabilities, handlers = handlers,
	init_options = {
		cache = {
			directory = ".ccls-cache";
		}
	},
	root_dir = require'lspconfig'.util.root_pattern('.ccls-root', '.ccls', '.git'),
	flags = {debounce_text_changes = 500},
	offset_encodig = 'utf-8'
}
EOF
sign define LspDiagnosticsSignError text=>> texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text=>> texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text=>> texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text=>> texthl=LspDiagnosticsSignHint linehl= numhl=
" }}}

" vim-modern-cpp {{{
let g:cpp_attributes_highlight = 1
let g:cpp_simple_highlight = 1
" }}}

" asyncrun.vim {{{
let asyncrun_open = 8
nnoremap <f8> :AsyncRun -post=call\ AsyncRunPost() make<cr>
nnoremap <f6> :! ./.vimrun<cr>

function! AsyncRunPost()
	copen
	wincmd p
	if len(filter(getqflist(), {k,v -> v.valid})) == 0
		cclose
	endif
endfunction
" }}}

" termdebug {{{
packadd termdebug

function! s:RunTermdebug(file)
	let return_window = win_getid()

	execute 'Termdebug ' . a:file

	let gdb_window = win_getid(bufwinnr('gdb'))
	let program_window = win_getid(bufwinnr('gdb program'))

	let combined_height = nvim_win_get_height(gdb_window) + nvim_win_get_height(program_window)
	let resize_program_command = 'winnr("k") . ' . '"resize +' . (combined_height - 20) . '"'

	call win_execute(program_window, 'wincmd J')
	call win_execute(gdb_window, 'wincmd J')
	call nvim_win_set_height(gdb_window, 10)
	call win_execute(program_window, 'execute ' . resize_program_command)

	call win_gotoid(return_window)
endfunction

nnoremap <leader>dg :Gdb<cr>:startinsert<cr>
nnoremap <leader>dp :Program<cr>
nnoremap <leader>ds :Source<cr>
nnoremap <leader>dd :call <SID>RunTermdebug('.vimrun')<cr>
nnoremap <leader>dq :Gdb<cr>:startinsert<cr>quit<cr>
" }}}
" }}}

let g:helper_files = ['plugin-managment.vim', 'quickfix.vim', 'terminal.vim', 'window-changing.vim', 'latex-integration.vim']

let g:helper_root = expand('<sfile>:p:h') . '/helper/'

for file in g:helper_files
	execute 'source ' . helper_root . file
endfor
