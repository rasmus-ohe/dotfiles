vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- window management
---- split window
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sq", "<cmd>close<CR>", { desc = "Close current split" })

---- tabs
keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tq", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tr", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tl", "<cmd>tabp<CR>", { desc = "Go to previous tab" })

---- quitting
keymap.set('n', '<leader>qq', '<cmd>q<CR>', { desc = 'Quit Neovim (current buffer)' })
keymap.set('n', '<leader>qa', '<cmd>qa<CR>', { desc = 'Quit Neovim (all)' })

---- saving
keymap.set('n', '<leader>ww', '<cmd>w<CR>', { desc = 'Save Neovim' })
keymap.set('n', '<leader>wa', '<cmd>wa<CR>', { desc = 'Save all Neovim buffers' })
keymap.set('n', '<leader>wq', '<cmd>wq<CR>', { desc = 'Save and quit Neovim' })

--- search
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { silent = true, desc = "Esc clears search highlight" })