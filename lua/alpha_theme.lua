local alpha_theme = {}

local function button(sc, txt, vim_cmd)
	return
	{
		type = "button", val = txt, on_press = function() vim.cmd(vim_cmd) end,
		opts = {
			position = "left", shortcut = "[" .. sc .. "] ", align_shortcut = "left", hl_shortcut = {{"Normal", 0, 1}, {"Number", 1, #sc + 1}, {"Normal", #sc + 1, #sc + 2}}, hl = "Comment", cursor = 1,
			keymap = { "n", sc, "<cmd>" .. vim_cmd .. "<cr>", {noremap = false, silent = true, nowait = true }},
		}
	}
end
local function file_button(sc, file_name)
	return button(sc, file_name, "edit " .. file_name)
end
local function session_button(sc, session_file)
	return button(sc, session_file, "source " .. session_file)
end

local function bookmarks(list)
	local buttons = {}
	for _, bm in ipairs(list) do
		table.insert(buttons, file_button(bm[1], bm[2]))
	end
	return buttons
end

local function commands(list)
	local buttons = {}
	for _, cm in ipairs(list) do
		table.insert(buttons, button(cm[1], cm[2], cm[3]))
	end
	return buttons
end

local function sessions(session_dir)
	local list =  vim.fn.globpath(session_dir, "*", false, true)
	local buttons = {}
	local i = 0
	for _, sn in ipairs(list) do
		local session_name = sn:match("^.+/(.+)$")
		if session_name ~= '__LAST__' then
			table.insert(buttons, button(i .. "", session_name, "source " .. sn))
			i = i + 1
		end
	end
	return buttons
end

function alpha_theme.opts(header_text, bookmark_list, command_list, session_dir)
	local section = {
		header = {
			type = "group",
			val = {
				{ type = "padding", val = 1 },
				{type = "text", val = header_text, opts = {hl = "Type", shrink_margin = false}},
				{ type = "padding", val = 2 },
			}
		},
		commands = {
			type = "group",
			val = {
					{ type = "padding", val = 1 },
					{ type = "text", val = "Commands", opts = { hl = "SpecialComment" } },
					{ type = "padding", val = 1 },
					{
						type = "group",
						val = commands(command_list)
					},
			},
		},
		bookmarks = {
			type = "group",
			val = {
					{ type = "padding", val = 1 },
					{ type = "text", val = "Bookmarks", opts = { hl = "SpecialComment" } },
					{ type = "padding", val = 1 },
					{
						type = "group",
						val = bookmarks(bookmark_list)
					},
			},
		},
		sessions = {
			type = "group",
			val = {
					{ type = "padding", val = 1 },
					{ type = "text", val = "Sessions", opts = { hl = "SpecialComment" } },
					{ type = "padding", val = 1 },
					{
						type = "group",
						val = sessions(session_dir)
					},
			},
		},
	}

	local opts = {
		layout = {
			section.header,
			section.commands,
			section.bookmarks,
			section.sessions,
		},
		opts = {
			margin = 3
		},
	}
	return opts
end

return alpha_theme
