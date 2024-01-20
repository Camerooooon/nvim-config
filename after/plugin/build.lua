local function find_git_root()
    local result = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")
    return #result > 0 and result[1] or nil
end


function Run_gradle_deploy()
    local job_id = vim.fn.jobstart('./gradlew build', {
        on_stderr = function(_, data, _)
            print(data)
        end,
        on_stdout = function(_, data, _)
            print(data)
        end,
        on_exit = function(_, code, _)
            if code == 0 then
                print("Gradle command executed successfully.")
            else
                print("Gradle command failed with code " .. code .. ".")
            end
        end,
        detach = true,
        cwd = find_git_root(),
    })
end

vim.api.nvim_set_keymap('n', '<leader>d', ':lua Run_gradle_deploy()<CR>', { noremap = true, silent = true })
