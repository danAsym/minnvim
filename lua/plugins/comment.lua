-- comment.lua
-- Purpose: Efficient code commenting functionality across various languages

return {
  -- Plugin source: part of the mini.nvim suite
  "echasnovski/mini.comment",

  -- Lazy loading: loads after Neovim starts up, reducing initial startup time
  event = "VeryLazy",

  -- Plugin configuration
  opts = {}, -- Using default options. Customize by adding key-value pairs here if needed
}

-- Note: Automatically detects appropriate comment style based on file type
