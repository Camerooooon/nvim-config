local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')
local cond = require('nvim-autopairs.conds')

local ts_conds = require('nvim-autopairs.ts-conds')

npairs.add_rules({
    Rule("$", "$", "typst")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
    :with_move(cond.move_right)
    :with_pair(cond.not_add_quote_inside_quote())
})
