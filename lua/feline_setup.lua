local feline_theme = {}

local feline = require'feline'

local vi_mode_colors = {
    n = "green",
    v = "orange",
    V = "orange",
    [''] = "orange",
    s = "orange",
    S = "orange",
    R = "aqua",
    i = "blue",
    c = "grey",
    r = "grey",
	 ['!'] = "grey",
	 t = "grey"
}

local vi_mode_text = {
    n = "NORMAL",
    v = "VISUAL",
    V = "V-LINE",
    [''] = "V-BLOCK",
    s = "SELECT",
    S = "SELECT",
    R = "REPLACE",
    i = "INSERT",
    c = "COMMAND",
    r = "CONFIRM",
	 ['!'] = "EXECUTE",
	 t = "TERMINAL"
}

function feline_theme.mode()
	return {
		provider = function()
				return ' ' .. vi_mode_text[vim.fn.mode():sub(1,1)] .. ' '
		end,
		hl = function()
				return {
					name = 'StatusComponentMode' .. vi_mode_text[vim.fn.mode():sub(1,1)],
					fg = 'bg',
					bg = vi_mode_colors[vim.fn.mode():sub(1,1)],
					style = 'bold'
				}
		end
	}
end

function feline_theme.file_name(detailed, hl)
	if detailed then
		return {
			provider = function()
				local filename = vim.fn.expand('%:t')
				return (vim.o.readonly and "🔒" or "") .. ((filename ~= "") and filename or "-") .. (vim.o.modified and "[+]" or "")
			end,
			hl = hl
		}
	else
		return {
			provider = function()
				local filename = vim.fn.expand('%:.')
				return (filename ~= "") and filename or "-"
			end,
			hl = hl
		}
	end
end

function feline_theme.file_type(hl)
	return {
		provider = function()
			local ft = vim.o.filetype if ft == "" then ft = "-" end
			return ft
		end,
		hl = hl
	}
end

function feline_theme.position_info(hl)
	return {
		provider = function() return string.format("%.0f%%%%/%d:%d", vim.fn.line('.') / vim.fn.line('$') * 100, vim.fn.line('.'), vim.fn.col('.')) end,
		hl = hl
	}
end

function feline_theme.highlight(hl)
	return {provider = '', hl = hl}
end

function feline_theme.vertical_bar(hl)
	return {
		provider = '|',
		hl = hl
	}
end
function feline_theme.space(hl)
	return {
		provider = ' ',
		hl = hl
	}
end

return feline_theme
