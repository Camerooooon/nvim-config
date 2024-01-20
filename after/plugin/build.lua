local function find_git_root()
    local result = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")
    return #result > 0 and result[1] or nil
end


function Run_gradle_deploy()
    local output = ""
    local notification
    local notify = function(msg, level)
        local notify_opts = vim.tbl_extend(
        "keep",
        opts or {},
        { replace = notification }
        )
        notification = vim.notify(msg, level, notify_opts)
    end
    notify("Deploying code to roborio")
    local on_data = function(_, data)
        output = output .. table.concat(data, "\n")
    end
    local job_id = vim.fn.jobstart('./gradlew deploy --console plain', {
        on_stderr = on_data,
        on_stdout = on_data,
        on_data = on_data,
        on_exit = function(_, code, _)
            if code == 0 then
                notify("Gradle deploy executed successfully.", "info")
            else
                notify("Gradle deploy failed with code " .. code .. ".\n" .. output, "error")
            end
        end,
        cwd = find_git_root(),
    })
end

vim.api.nvim_set_keymap('n', '<leader>d', ':lua Run_gradle_deploy()<CR>', { noremap = true, silent = true })
