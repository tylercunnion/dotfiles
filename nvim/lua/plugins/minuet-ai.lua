return {
    "milanglacier/minuet-ai.nvim",
    opts = {
        provider = "openai_compatible",
        n_completions = 1,
        context_window = 16384,
        request_timeout = 15,
        provider_options = {
            openai_compatible = {
                end_point = "http://localhost:1234/v1/chat/completions",
                stream = true,
                name = "LMStudio",
                api_key = 'TERM',
                model = "mistralai/devstral-small-2-2512",
                optional = {
                    temperature = 0.15,
                    max_tokens = 256,
                },
            }
        }
    }
}
