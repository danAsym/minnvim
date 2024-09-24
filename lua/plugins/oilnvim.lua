return {
  'stevearc/oil.nvim',
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function()
    require("oil").setup({
      columns = { "icon" },
      keymaps = {
        ["<C-h>"] = false,
        ["<M-h>"] = "actions.select_split",
        ["h"] = "actions.parent",
        ["l"] = "actions.select",
        ["o"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["O"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
      },
      view_options = {
        show_hidden = true,
      }
    })
  end
}
