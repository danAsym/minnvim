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
      },
      view_options = {
        show_hidden = true,
      }
    })
  end
}
