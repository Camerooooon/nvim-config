
function InsertFigure()
    -- Define the path to the template directory and the template filename
    local templateDir = "/home/cameron/Notebook/templates/"

    -- Get a list of template files in the template directory
    local templateFiles = vim.fn.globpath(templateDir, '*.xopp', false, true)

    -- Prompt for a figure name
    local figureName = vim.fn.input("Enter figure name: ")

    -- Get the current buffer's directory and construct the destination path
    local currentBufferDir = vim.fn.expand('%:p:h')
    local figuresDir = currentBufferDir .. '/figures'
    local destinationPath = figuresDir .. '/' .. figureName .. '.xopp'

    if vim.fn.isdirectory(figuresDir) == 0 then
        vim.fn.mkdir(figuresDir, "p")
    end

    -- Check if the destination file already exists
    local fileExists = vim.fn.filereadable(destinationPath) > 0
    if fileExists then
        OpenFigure(destinationPath)
        return
    end

    -- Use Telescope to select a template
    local selectedTemplate = require('telescope.pickers').new({}, {
        prompt_title = "Select a template",
        finder = require('telescope.finders').new_table {
            results = templateFiles,
        },
        sorter = require('telescope.sorters').get_fuzzy_file(),
        attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry(prompt_bufnr)
                require('telescope.actions').close(prompt_bufnr)
                CreateFigure(selection.value, destinationPath, figureName)
            end)
            return true
        end,
    }):find()

    if not selectedTemplate then
        return
    end

end

function CreateFigure(templatePath, destinationPath, figureName)


    -- Copy the template file to the destination path
    local copyCommand = string.format('cp %s %s', templatePath, destinationPath)
    vim.fn.system(copyCommand)

    OpenFigure(destinationPath)

    local figureInsertion = '![](./figures/' .. figureName .. '.pdf)'
    vim.cmd('normal! i' .. figureInsertion)
end


function OpenFigure(path)
    local openCommand = 'xournalpp ' .. vim.fn.shellescape(path) .. ' &'
    vim.fn.jobstart(openCommand)
end

