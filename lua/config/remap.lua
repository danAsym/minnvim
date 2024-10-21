-- ======================================
-- AUTOCMDS
-- ======================================
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.norg" },
  command = "set conceallevel=3",
})


-- ======================================
-- VIM KEYMAPS
-- ======================================
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<Tab>", ":tabnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":tabprev<CR>", opts)
vim.keymap.set("v", "<Tab>", ">gv", opts)
vim.keymap.set("v", "<S-Tab>", "<gv", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "N", "Nzz", opts)
vim.keymap.set("n", "-", ":split<CR>", opts)
vim.keymap.set("n", "|", ":vsplit<CR>", opts)
vim.keymap.set("n", "=", "<C-w>=<cr>", opts)


local function toggle_quickfix()
  local qf_exists = false

  for _, win in pairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      qf_exists = true
      break
    end
  end

  if qf_exists then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end

local function highlight_vimgrep()
  local pattern = vim.fn.input("Enter search pattern (regex): ")
  local file_type = vim.fn.input("Enter file type (eg: **/*.lua, src/**): ")
  local cmd_str = string.format("vimgrep /%s/ %s", pattern, file_type)
  vim.cmd(cmd_str)
  vim.cmd("copen")
  vim.cmd("set hlsearch")
end

vim.keymap.set("n", "<leader>mq", toggle_quickfix, { noremap = true, silent = true, desc = "Toggle qfixlist" })
vim.keymap.set("n", "<leader>mj", "<cmd>cnext<CR>zz", { noremap = true, silent = true, desc = "Forward qfixlist" })
vim.keymap.set("n", "<leader>mk", "<cmd>cprev<CR>zz", { noremap = true, silent = true, desc = "Backward qfixlist" })
vim.keymap.set("n", "<leader>mv", highlight_vimgrep, { noremap = true, silent = true, desc = "Vimgrep to qfixlist" })


vim.keymap.set("n", "<leader>ml", "<cmd>lnext<CR>zz", { noremap = true, silent = true, desc = "Forward loclist" })
vim.keymap.set("n", "<leader>mh", "<cmd>lprev<CR>zz", { noremap = true, silent = true, desc = "Backward loclist" })
