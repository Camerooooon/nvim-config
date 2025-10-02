local live_compile_enabled = false
local job_id = nil

local function compile_temp_from_buffer()
  local buf_contents = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local temp_path = "/tmp/nvim_typst_temp.typ"

  -- Write current buffer contents to a temp file
  local fd = io.open(temp_path, "w")
  if fd then
    for _, line in ipairs(buf_contents) do
      fd:write(line .. "\n")
    end
    fd:close()
  else
    vim.notify("Failed to write temp file", vim.log.levels.ERROR)
    return
  end

  -- Stop previous compile if it's still running
  if job_id ~= nil then
    vim.fn.jobstop(job_id)
  end

  -- Run typst compile on the temp file
  job_id = vim.fn.jobstart({ "typst", "compile", temp_path }, {
    on_exit = function(_, code, _)
      if code ~= 0 then
        -- vim.notify("Typst compile failed (insert mode)", vim.log.levels.ERROR)
      end
    end,
  })
end

local function show_typst_error_output(lines)
  -- Create a new scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, "filetype", "typst")

  -- Create a floating window
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.4)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })
end

local function compile_real_file()
  local file = vim.fn.expand("%:p")
  if vim.fn.filereadable(file) == 0 then
    return
  end

  -- Stop previous job if still running
  if job_id ~= nil then
    vim.fn.jobstop(job_id)
  end

  local stderr = {}

  job_id = vim.fn.jobstart({ "typst", "compile", file }, {
    stderr_buffered = true,
    on_stderr = function(_, data, _)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(stderr, line)
          end
        end
      end
    end,
    on_exit = function(_, code, _)
      if code ~= 0 then
        if #stderr > 0 then
          -- vim.schedule(function()
          --   show_typst_error_output(stderr)
          -- end)
        else
          --vim.notify("Typst compile failed but no error output received", vim.log.levels.ERROR)
        end
      end
    end,
  })
end


function ToggleTypstLiveCompile()
  live_compile_enabled = not live_compile_enabled
  if live_compile_enabled then
    vim.notify("Typst auto refresh has been enabled", vim.log.levels.SUCCESS)
    local group = vim.api.nvim_create_augroup("TypstLiveCompile", { clear = true })

    vim.api.nvim_create_autocmd("TextChangedI", {
      group = group,
      pattern = "*.typ",
      callback = compile_temp_from_buffer,
    })

    vim.api.nvim_create_autocmd("BufWritePost", {
      group = group,
      pattern = "*.typ",
      callback = compile_real_file,
    })
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = group,
      pattern = "*.typ",
      callback = compile_temp_from_buffer,
    })
  else
    vim.notify("Typst auto refresh has been disabled", vim.log.levels.SUCCESS)
    vim.api.nvim_clear_autocmds({ group = "TypstLiveCompile" })
  end
end

vim.api.nvim_create_user_command("TypstLiveCompileToggle", ToggleTypstLiveCompile, {})

-- Keybindings
vim.keymap.set("n", "<leader>l", "<cmd>:AsyncRun zathura ''%<.pdf''<CR>")
vim.keymap.set("n", "<leader>j", "<cmd>:AsyncRun zathura /tmp/nvim_typst_temp.pdf<CR>")
vim.keymap.set("n", "<leader>k", "<cmd>:TypstLiveCompileToggle<CR>")

