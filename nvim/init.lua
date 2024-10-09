-- Basic settings
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.api.nvim_set_keymap('n', '<Leader>e', ':Explore<CR>', { noremap = true, silent = true })

vim.opt.swapfile = false
vim.opt.number = true
vim.opt.relativenumber = true

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Lazy.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Function to set colorscheme
function Colorfix()
    vim.cmd.colorscheme("rose-pine")
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Optional: Additional configurations for other plugins can be added here
require("lazy").setup({
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            Colorfix()  -- Call the function to set the colorscheme
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = { "yaml", "bash", "json" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
})

-- Enable true colors support
vim.o.termguicolors = true

vim.cmd[[highlight Comment guifg=#3D9970 ctermfg=Green]]

local function setup_wsl_yank()
    local clip_path = "/mnt/c/Windows/System32/clip.exe" -- Change this path if needed
    if vim.fn.executable(clip_path) == 1 then
        vim.api.nvim_create_augroup("WSLYank", { clear = true })
        vim.api.nvim_create_autocmd("TextYankPost", {
            group = "WSLYank",
            pattern = "*",
            callback = function()
                if vim.v.event.operator == 'y' then
                    local temp = vim.fn.getreg('"')
                    temp = temp:gsub('\r', '')  -- Remove any carriage returns
                    vim.fn.system(clip_path, temp)
                end
            end,
        })
    end
end

setup_wsl_yank()

vim.opt.fileformat = "unix"

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "ansiblels", "jsonls", "bashls" },
})

-- LSP configuration for ansiblels
require("lspconfig").ansiblels.setup({
    on_attach = function(client, bufnr)
        if vim.lsp.buf.lint then
            vim.keymap.set('n', '<leader>l', function() vim.lsp.buf.lint() end, { noremap = true, silent = true })
        end
    end,
    filetypes = { "yaml", "yml" },
})

-- LSP configuration for jsonls
require("lspconfig").jsonls.setup({
    on_attach = function(client, bufnr)
        if vim.lsp.buf.lint then
            vim.keymap.set('n', '<leader>l', function() vim.lsp.buf.lint() end, { noremap = true, silent = true })
        end
    end,
    filetypes = { "json" },
})

-- LSP configuration for bashls
require("lspconfig").bashls.setup({
    on_attach = function(client, bufnr)
        if vim.lsp.buf.lint then
            vim.keymap.set('n', '<leader>l', function() vim.lsp.buf.lint() end, { noremap = true, silent = true })
        end
    end,
    filetypes = { "sh" },
})

-- Optional: Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.yml", "*.sh", "*.json" },
    callback = function()
        vim.lsp.buf.format()
    end,
})

