vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "html", "css", "json", "lua", "htmldjango" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

vim.opt.signcolumn = "yes"

vim.opt.clipboard = "unnamedplus"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            pickers = {
                buffers = {
                    mappings = {
                        i = {
                            ["<C-d>"] = function(...)
                                return require("telescope.actions").delete_buffer(...)
                            end,
                        },
                    },
                },
            },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({
                "python",
                "javascript",
                "typescript",
                "tsx",
                "html",
                "css",
                "json",
                "lua",
            })
            vim.treesitter.language.register("html", "htmldjango")
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = { map_cr = false },
    },
    {
        "nickkadutskyi/jb.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("jb")
        end,
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "File tree" },
        },
        opts = {},
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            current_line_blame = true,
            current_line_blame_opts = { delay = 500 },
        },
    },
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        opts = {
            formatters_by_ft = {
                python = { "ruff_format" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
            },
            format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
        },
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "LazyGit" },
        keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
    },
    {
        "echasnovski/mini.surround",
        event = "VeryLazy",
        opts = {},
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        },
        opts = {},
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
})

vim.diagnostic.config({ virtual_text = true })

vim.lsp.enable({ "basedpyright", "html", "cssls", "jsonls", "ts_ls" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "python",
        "javascript",
        "typescript",
        "typescriptreact",
        "javascriptreact",
        "json",
        "html",
        "css",
        "lua",
        "htmldjango",
    },
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find text" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })

vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.opt.autocomplete = true
vim.opt.autocompletedelay = 150
vim.opt.pumheight = 8

vim.keymap.set("i", "<Tab>", function()
    return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true, desc = "Next completion item" })
vim.keymap.set("i", "<S-Tab>", function()
    return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true, desc = "Previous completion item" })
vim.keymap.set("i", "<CR>", function()
    if vim.fn.pumvisible() == 1 and vim.fn.complete_info({ "selected" }).selected ~= -1 then
        return vim.keycode("<C-y>")
    end
    return require("nvim-autopairs").autopairs_cr()
end, { expr = true, replace_keycodes = false, desc = "Accept completion item" })
vim.opt.complete = "o,.,w,b,u"

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        vim.lsp.semantic_tokens.enable(false, { bufnr = event.buf })
    end,
})
