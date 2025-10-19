vim.o.number = true
require("config.lazy")
vim.cmd.colorscheme "catppuccin"

local function open_nvim_tree()
    require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd(
    { "VimEnter" }, 
    { callback = open_nvim_tree }
)

-- require('blink.cmp').setup({})
-- require'nvim-treesitter'.install { 'cpp', 'python', 'bash' }
-- require('nvim-treesitter').setup
-- {
--     highlight = { enable = true, },
--     indent = { enable = true, },
--     -- ensure_installed = 'all', -- :TSInstall allと同じ
--     -- ensure_installed = 'maintained'
-- }
-- require('nvim-treesitter').install{ 'cpp', 'python', 'bash' }
-- require("nvim-treesitter").setup({highlight = { enable = true, }})
-- vim.api.nvim_create_autocmd("FileType", {
--   group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
--   callback = function(ctx)
--     -- 必要に応じて`ctx.match`に入っているファイルタイプの値に応じて挙動を制御
--     -- `pcall`でエラーを無視することでパーサーやクエリがあるか気にしなくてすむ
--     pcall(vim.treesitter.start)
--   end,
-- })

-- require("nvim-treesitter.configs").setup {}
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("my.lsp", {}),
--   callback = function(args)
--     local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--     -- 補完の設定
--     if client:supports_method('textDocument/completion') then
--       -- 文字を入力する度に補完を表示（遅くなる可能性あり）
--       local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
--       client.server_capabilities.completionProvider.triggerCharacters = chars
--       -- 補完を有効化
--       vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
--     end
--     -- フォーマット
--     if not client:supports_method('textDocument/willSaveWaitUntil')
--       and client:supports_method('textDocument/formatting') then
--       vim.api.nvim_create_autocmd('BufWritePre', {
--         group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
--         buffer = args.buf,
--         callback = function()
--           vim.lsp.buf.format({bufnr = args.buf, id = client.id, timeout_ms = 3000})
--         end,
--       })
--     end
--   end,
-- })

-- Use lspconfig instead of the deprecated vim.lsp.* framework API
-- Prefer the new built-in framework API if present to avoid lspconfig deprecation warnings
-- if vim.lsp and type(vim.lsp.config) ~= 'nil' then
--     -- Use vim.lsp.config/vim.lsp.enable when available
--     pcall(function()
--         vim.lsp.config('clangd', {})
--         if type(vim.lsp.enable) == 'function' then
--             vim.lsp.enable({ 'clangd' })
--         end
--         vim.lsp.config('bashls', {})
--         if type(vim.lsp.enable) == 'function' then
--             vim.lsp.enable({ 'bashls' })
--         end
--     end)
-- else
--     local ok_lsp, lspconfig = pcall(require, 'lspconfig')
--     if ok_lsp then
--         lspconfig.clangd.setup({})
--         lspconfig.bashls.setup({})
--     end
-- end
