return {

  -- noice
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          hover = {
            enabled = true,
            silent = true, -- set to true to not show a message if hover is not available
            view = nil,    -- when nil, use defaults from documentation
            ---@type NoiceViewOptions
            opts = {},     -- merged with defaults from documentation
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      })
    end,

  },

  -- notify
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#000000",
      })
    end,
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    name = "lualine",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local breadcrump_sep = " ⟩ "
      require("lualine").setup({
        sections = {
          lualine_c = {
            {
              "filename",
              path = 1,
              separator = vim.trim(breadcrump_sep),
              fmt = function(str)
                local path_separator = package.config:sub(1, 1)
                return str:gsub(path_separator, breadcrump_sep)
              end,
            },
          },
        },
      })
    end,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    config = function()
      require("rose-pine").setup({
        variant = "main",
        dim_inactive_windows = true,
        styles = {
          transparency = false,
        },
        -- highlight_groups = {
        --   CurSearch = { fg = "base", bg = "leaf", inherit = false },
        --   Search = { fg = "text", bg = "leaf", blend = 20, inherit = false },
        --   TelescopeBorder = { fg = "overlay", bg = "overlay" },
        --   TelescopeNormal = { fg = "subtle", bg = "overlay" },
        --   TelescopeSelection = { fg = "text", bg = "highlight_med" },
        --   TelescopeSelectionCaret = { fg = "love", bg = "highlight_med" },
        --   TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },
        --
        --   TelescopeTitle = { fg = "base", bg = "love" },
        --   TelescopePromptTitle = { fg = "base", bg = "pine" },
        --   TelescopePreviewTitle = { fg = "base", bg = "iris" },
        --
        --   TelescopePromptNormal = { fg = "text", bg = "surface" },
        --   TelescopePromptBorder = { fg = "surface", bg = "surface" },
        -- },
      })
    end,
  },

  -- dressing
  {
    "stevearc/dressing.nvim",
    lazy = false,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.bufremove",
    },
    opts = {
      options = {
        themable = true,
        close_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        right_mouse_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        numbers = function(opts)
          return string.format('%s.%s', opts.lower(opts.id), opts.lower(opts.ordinal))
        end,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
          },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
    end,
  },
}
