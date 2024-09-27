-- lua/custom/game.lua
local M = {}

-- Game state variables
M.buf = nil
M.win = nil
M.ns_id = nil
M.game_state = {}

-- Module Functions

-- Starts the game
function M.start()
  M.buf = M.create_buffer()
  M.win = M.open_window(M.buf)
  M.ns_id = vim.api.nvim_create_namespace('just_move')

  M.init_game_state()
  M.update_display()
  M.setup_keymaps(M.buf)
end

-- Creates the game buffer
function M.create_buffer()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].filetype = 'game'
  return buf
end

-- Opens the game window
function M.open_window(buf)
  local width = math.floor(vim.o.columns * 0.6)
  local height = math.floor(vim.o.lines * 0.6)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  -- Set window options
  vim.wo[win].cursorline = true
  vim.wo[win].number = false

  return win
end

-- Initializes the game state
function M.init_game_state()
  M.game_state = {
    -- Define initial game variables
    player_position = { line = 1, col = 1 },
    target_position = { line = 5, col = 10 },
    score = 0,
  }
end

function M.place_symbol_in_line(line, col, symbol)
  return line:sub(1, col - 1) .. symbol .. line:sub(col + 1)
end

function M.find_symbol_in_map(symbol)
  for i, line in ipairs(M.game_state.map) do
    local col = string.find(line, symbol)
    if col then
      return { line = i - 1, col = col - 1 }
    end
  end
  return nil
end

function M.apply_highlights()
  local ns_id = M.ns_id
  local buf = M.buf
  local player_pos = M.find_symbol_in_map('@')
  local target_pos = M.find_symbol_in_map('X')

  if player_pos then
    vim.api.nvim_buf_add_highlight(buf, ns_id, 'String', player_pos.line, player_pos.col, player_pos.col + 1)
  end

  if target_pos then
    vim.api.nvim_buf_add_highlight(buf, ns_id, 'WarningMsg', target_pos.line, target_pos.col, target_pos.col + 1)
  end
end

function M.add_virtual_text()
  local buf = M.buf
  local ns_id = M.ns_id
  local target_pos = M.find_symbol_in_map('X')

  if target_pos then
    vim.api.nvim_buf_set_extmark(buf, ns_id, target_pos.line, target_pos.col, {
      virt_text = { { "<-- Target", "Comment" } },
      virt_text_pos = 'eol'
    })
  end
end

function M.move_cursor_to_player()
  local player_pos = M.find_symbol_in_map('@')

  if player_pos then
    vim.api.nvim_win_set_cursor(M.win, { player_pos.line + 1, player_pos.col })
  end
end

-- Updates the game display
function M.update_display()
  -- define map
  local map = {
    "+-----------------+",
    "|                 |",
    "|                 |",
    "|                 |",
    "|                 |",
    "|                 |",
    "+-----------------+",
  }

  map[M.game_state.player_position.line] = M.place_symbol_in_line(
    map[M.game_state.player_position.line],
    M.game_state.player_position.col,
    '@'
  )

  map[M.game_state.target_position.line] = M.place_symbol_in_line(
    map[M.game_state.target_position.line],
    M.game_state.target_position.col,
    'X'
  )

  -- Clear the buffer and redraw game elements based on the game state
  vim.api.nvim_buf_set_lines(M.buf, 0, -1, false, map)

  M.game_state.map = map

  M.apply_highlights()

  M.add_virtual_text()

  M.move_cursor_to_player()
end

-- Sets up key mappings for the game buffer
function M.setup_keymaps(buf)
  -- Function to handle Esc key press
  local function on_escape()
    M.confirm_exit()
  end

  -- Set key mapping for Esc in normal and insert modes
  for _, mode in ipairs({ 'n', 'i' }) do
    vim.keymap.set(mode, '<Esc>', on_escape, { buffer = buf, silent = true })
  end

  -- Map movement keys
  local movement_keys = { 'h', 'j', 'k', 'l' }
  for _, key in ipairs(movement_keys) do
    vim.keymap.set('n', key, function() M.on_move(key) end, { buffer = buf, silent = true })
  end
end

-- Handles the Esc key press and prompts for confirmation
function M.confirm_exit()
  vim.ui.input({ prompt = "Are you sure you want to exit? (y/N): " }, function(input)
    if input and input:lower() == 'y' then
      M.close_window()
    else
      if M.win and vim.api.nvim_win_is_valid(M.win) then
        vim.api.nvim_set_current_win(M.win)
      end
    end
  end)
end

-- Closes the game window and cleans up resources
function M.close_window()
  if M.win and vim.api.nvim_win_is_valid(M.win) then
    vim.api.nvim_win_close(M.win, true)
  end
  if M.buf and vim.api.nvim_buf_is_valid(M.buf) then
    vim.api.nvim_buf_delete(M.buf, { force = true })
  end
  M.win = nil
  M.buf = nil
  M.ns_id = nil
  M.game_state = {}
end

-- Handles movement keys
function M.on_move(key)
  -- Custom logic for handling movement
  -- For now, we simulate normal movement
  vim.api.nvim_feedkeys(key, 'n', false)

  -- Update game state based on new cursor position
  M.check_player_position()
end

-- Checks if the player has reached the target position
function M.check_player_position()
  local pos = vim.api.nvim_win_get_cursor(M.win)
  print(pos[1], pos[2])
  if pos[1] == M.game_state.target_position.line and pos[2] == M.game_state.target_position.col then
    vim.notify("You reached the target!", vim.log.levels.INFO)
    M.game_state.score = M.game_state.score + 1
    -- Update game or reset
  end
end

return M
