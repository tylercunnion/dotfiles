return {
    'saghen/blink.cmp',
    dependencies = {
        'fang2hou/blink-copilot',
    },
    version = '1.*',
    opts = {
        keymap = {
            preset = 'none',
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-e>'] = { 'hide', 'fallback' },
            ['<C-y>'] = { 'select_and_accept' },
            ['<CR>'] = { 'accept', 'fallback' },
            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },
            ['<C-p>'] = { 'select_prev', 'fallback' },
            ['<C-n>'] = { 'select_next', 'fallback' },
            ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        },
        appearance = {
            nerd_font_variant = 'mono',
        },
        completion = {
            menu = {
                border = 'rounded',
                draw = {
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                if ctx.source_name == 'minuet' then
                                    return '󰚩'
                                end
                                return ctx.kind_icon .. ctx.icon_gap
                            end,
                        },
                    },
                },
            },
            documentation = {
                auto_show = true,
                window = { border = 'rounded' },
            },
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer', 'minuet' },
            providers = {
                minuet = {
                    name = "minuet",
                    module = "minuet.blink",
                    async = true,
                    score_offset = 50,
                    timeout_ms = 15000,
                },
            },
        },
    },
}
