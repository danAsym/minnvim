return {
  {
    dir = vim.fn.stdpath("config") .. "/lua/custom/game",
    name = "just-move",
    lazy = true,
    cmd = "JustMove",
    config = function()
      vim.api.nvim_create_user_command('JustMove', function()
        require('custom.justMove').start()
      end, {})
    end,
  },
}
