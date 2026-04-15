-- Profile selection via NVIM_PROFILE env var.
-- NVIM_PROFILE=minimal  →  lightweight editing only (no treesitter, LSP, DAP, etc.)
-- unset / anything else →  full development suite
local M = {}
M.full = os.getenv("NVIM_PROFILE") ~= "minimal"
return M
