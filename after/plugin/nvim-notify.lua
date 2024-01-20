local notify = require("notify");

notify.setup({
    background_colour="#1c2023",
    render="wrapped-compact",
    stages = "slide",
})

vim.notify = notify

