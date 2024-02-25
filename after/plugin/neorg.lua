require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.export"] = {},
        ["core.latex.renderer"] = {},
        ["core.export.markdown"] = {
            config = {
                extensions = {"all"},
            },
        },
        ["core.keybinds"] = {
            config = {
                hook = function(keybinds)
                    keybinds.remap_event("norg", "n", "<C-Space>", "core.qol.todo_items.todo.task_done")
                    keybinds.remap_event("norg", "i", "<C-l>", "core.esupports.hop.hop-link")
                    keybinds.remap_event("norg", "n", "<C-l>", "core.esupports.hop.hop-link")
                end,
            }
        },
        ["core.journal"] = {
            config = {
                workspace = "notes",
            },
        },
        ["core.completion"] = {
            config = {
                engine = "nvim-cmp"
            },
        },
        ["core.dirman"] = {
            config = {
                default_workspace = "default",
                workspaces = {
                    default = "~/Notebook_neorg",
                },
            },
        },
    },
}
