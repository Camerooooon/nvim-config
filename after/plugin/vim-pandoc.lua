function pandoc_async()

  local filename = vim.fn.expand('%:t:r')
    print("Running pandoc command asynchronously for file: " .. filename .. "...")
  local job_id = vim.fn.jobstart('pandoc "' .. filename .. '".md -o "' .. filename .. '.pdf" --lua-filter /home/cameron/pandoc_lua_filters/wiki_links.lua', {
    on_stderr = function(_, data, _)
      print(data)
    end,
    on_stdout = function(_, data, _)
      print(data)
    end,
    on_exit = function(_, code, _)
      if code == 0 then
        print("Pandoc command executed successfully.")
      else
        print("Pandoc command failed with code " .. code .. ".")
      end
    end,
    detach = true,
    cwd = vim.fn.expand('%:p:h'),
  })

  if job_id > 0 then
    print("Pandoc command started in the background.")
  else
    print("Failed to start Pandoc command.")
  end
end

vim.api.nvim_exec([[
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#modules#enabled=["folding", "formatting"]
let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#folding#fold_yaml = 1
let g:pandoc#folding#foldlevel_yaml = 1
let g:pandoc#folding#mode = "stacked"
let g:pandoc#command#autoexec_on_writes = 0
let g:pandoc#syntax#codeblocks#embeds#langs = ["rust", "python"]

" For some reason folding will not work unless PandocFolding stacked is called after the document is loaded
augroup AutoPandocFolding
    autocmd!
    autocmd BufReadPost *.md,*.markdown PandocFolding stacked
augroup END

augroup RunPandocAsync
    autocmd BufWritePost *.md silent lua pandoc_async()
augroup END

]], false)

vim.api.nvim_set_keymap("n", "<leader>t", ":lua FindAndOpenFile()<CR>", { noremap = true, silent = true })
function FindAndOpenFile()
    -- Get the current line and cursor position
    local line = vim.api.nvim_get_current_line()
    local _, col = unpack(vim.api.nvim_win_get_cursor(0))

    -- Find the substring between [ and ] on the line
    local end_pos, end_col = line:find("%]", col)
    if end_pos == nil or end_col == nil then
        print("Could not find a link to follow")
        return
    end
    local start_pos, start_col = line:reverse():find("%[", #line - end_pos)
    if end_pos == nil or end_col == nil or start_pos == nil or start_col == nil then
        print("Could not find a link to follow")
        return
    end

    if start_pos and end_pos and end_col > #line - start_col + 2 then
        local file_name = line:sub(#line - start_col + 2, end_col - 1)
        local file_path = vim.fn.findfile(file_name .. ".md", ".;")
        if file_path ~= "" then
            vim.cmd("edit " .. vim.fn.fnameescape(file_path))
            return
        else
            local cmd_output = vim.fn.systemlist('grep -irl --include="*" "' .. file_name .. '" .')
            for _, path in ipairs(cmd_output) do
                local full_path = vim.fn.fnamemodify(path, ':p')
                if vim.fn.filereadable(full_path) == 1 then
                    file_path = full_path
                    break
                end
            end
        end
        if file_path ~= "" then
            vim.cmd("edit " .. vim.fn.fnameescape(file_path))
        else
            print("File not found: " .. file_name)
        end
    else
        print("No file name found between [ and ]")
    end
end
