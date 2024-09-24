# minnvim

This repository contains my personal Neovim configuration, designed for an efficient and powerful editing experience.

## Structure

```
├── README.md
├── init.lua
├── lazy-lock.json
└── lua
    ├── config
    │   ├── lazy.lua
    │   ├── remap.lua
    │   ├── set.lua
    │   └── snippets.lua
    └── plugins/
```

## Key Features

- **Package Manager**: [Lazy.nvim](https://github.com/folke/lazy.nvim)
- **Colorscheme**: [Rose Pine](https://github.com/rose-pine/neovim)
- **Leader Key**: Space

## Configuration Highlights

### Core Settings (`lua/config/set.lua`)
- Contains Vim sets for tabs, appearance, and general behavior

### Key Mappings (`lua/config/remap.lua`)
- Custom keybindings for enhanced productivity

### Plugin Management (`lua/config/lazy.lua`)
- Lazy.nvim initialization and plugin loading

### Snippets (`lua/config/snippets.lua`)
- Custom snippet definitions

## Plugins (`lua/plugins/`)

The `lua/plugins/` directory contains configuration files for various plugins:

- **Comment**: Easy code commenting
- **Completions**: Auto-completion setup
- **Editor**: General editor enhancements
- **Harpoon**: Quick file navigation
- **Indentscope**: Visual indentation guides
- **LSP Config**: Language Server Protocol setup
- **LuaSnip**: Snippet engine
- **Mini Files**: Minimalist file explorer
- **Telescope**: Fuzzy finder
- **Treesitter**: Syntax highlighting and code navigation
- **UI**: User interface improvements
- **Which Key**: Keybinding helper

## Key Bindings

Here are some notable keybindings:
- `<leader>`: open which-key

- `<Tab>` / `<S-Tab>`: Navigate between tabs
- `[b` / `]b`: Cycle through buffers
- `<C-d>` / `<C-u>`: Scroll down/up (centered)
- `-` / `|`: Split horizontally/vertically
- `<leader>e`: Open file explorer
- `ga`: Add file to Harpoon
- `gh`: Toggle Harpoon telescope
- `<leader>b`: Buffer-related commands
- `<leader>f`: Find (Telescope) commands
- `<leader>l`: LSP-related commands
- `<leader>s`: Various shortcuts (replace, yank, delete, etc.)
- `<leader>x`: Extra commands (Todo, Noice, Lazy, Mason)

## LSP Features

- Diagnostics viewing with Telescope and Trouble
- Code actions
- Symbol navigation
- Import organization

## Additional Features

- Integration with Telescope for enhanced searching
- Custom autocmds for file-specific settings
- LuaSnip for advanced snippet functionality
- Which Key for discoverable keybindings

## Installation

1. Backup your existing Neovim configuration
```bash
# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```
2. Clone this repository into your Neovim configuration directory (`~/.config/nvim`)
3. Launch Neovim to automatically install plugins


## Tips and Tricks


### Pure Neovim

#### Movements
- `h`, `j`, `k`, `l`: Basic left, down, up, right movements
- `w`: Move to the start of the next word
- `b`: Move to the start of the previous word
- `e`: Move to the end of the current word
- `0`: Move to the start of the line
- `$`: Move to the end of the line
- `gg`: Go to the first line of the document
- `G`: Go to the last line of the document
- `{`: Jump to previous paragraph
- `}`: Jump to next paragraph
- `Ctrl-u`: Move up half a screen
- `Ctrl-d`: Move down half a screen
- `%`: Jump to matching parenthesis or bracket

#### Searching
- `/pattern`: Search forward for pattern
- `?pattern`: Search backward for pattern
- `n`: Repeat search in same direction
- `N`: Repeat search in opposite direction
- `*`: Search forward for word under cursor
- `#`: Search backward for word under cursor

#### Find and Till
- `f{char}`: Find next occurrence of {char} on the current line
- `F{char}`: Find previous occurrence of {char} on the current line
- `t{char}`: Till before next occurrence of {char}
- `T{char}`: Till after previous occurrence of {char}
- `;`: Repeat last f, F, t, or T movement
- `,`: Repeat last f, F, t, or T movement, backwards

#### Text Objects (prefix with any, ex: y/v/c)
- `iw`: Inner word
- `aw`: A word (includes surrounding space)
- `is`: Inner sentence
- `as`: A sentence
- `ip`: Inner paragraph
- `ap`: A paragraph

#### Editing
- `c`: Change (delete and enter insert mode)
- `d`: Delete
- `y`: Yank (copy)
- `p`: Put (paste) after cursor
- `P`: Put (paste) before cursor
- `r`: Replace single character
- `~`: Toggle case of character under cursor

#### Search and Replace
- `:s/foo/bar/g`: Replace foo with bar on current line
- `:%s/foo/bar/g`: Replace foo with bar in entire file
- `:%s/foo/bar/gc`: Replace foo with bar in entire file with confirmations

### With Plugins

#### Telescope
- `<leader>ff`: Find files
- `<leader>fg`: Live grep
- `<leader>fb`: Buffers
- `<leader>fh`: Help tags

#### Harpoon
- `<leader>a`: Add file to Harpoon
- `<C-e>`: Toggle quick menu

#### Which Key
- `<leader>`: Show available keybindings

#### LSP
- `gd`: Go to definition
- `gr`: Go to references
- `gi`: Go to implementation
- `K`: Hover documentation
- `<leader>ca`: Code action
- `<leader>rn`: Rename

#### Treesitter
- Improved syntax highlighting
- Incremental selection: `gnn`, `grn`, `grc`, `grm`

#### Comment.nvim
- `gcc`: Toggle line comment
- `gbc`: Toggle block comment

#### LuaSnip
- `<C-k>`: Expand snippet
- `<C-j>`: Jump to next snippet placeholder
- `<C-k>`: Jump to previous snippet placeholder

#### Registers
- `:reg`: shows registers
- `"0p` - get the content from register 0 and paste it


### Combined Operations

Vim's true power comes from combining its various commands. Here are some examples of powerful combined operations:

- `ciw`: Change inner word (delete the word under cursor and enter insert mode)
- `ct,`: Change until the next comma (delete from cursor to next comma and enter insert mode)
- `d2j`: Delete 2 lines down
- `y$`: Yank (copy) from cursor to end of line
- `di"`: Delete everything inside quotes
- `ca"`: Change around quotes (delete quotes and their content, then enter insert mode)
- `>ap`: Indent a paragraph
- `gUaw`: Make a word uppercase
- `=G`: Auto-indent from cursor to end of file
- `!ipjq`: Format a paragraph using the external 'jq' command (useful for JSON)

#### Search and Replace Workflow
- `*`: Search for word under cursor
- `ciw`: Change the word
- `n`: Go to next occurrence
- `.`: Repeat the change

This workflow (`* | ciw | n | .`) allows you to change occurrences of a word one by one, with the option to skip any you don't want to change.

#### Text Object Operations
- `vip`: Select inner paragraph
- `yip`: Yank inner paragraph
- `cip`: Change inner paragraph

#### Advanced Examples
- `f"ci"`: Find the next quote and change its contents
- `%v$y`: Jump to matching brace, visually select to end of line, and yank
- `ggVG=`: Go to top of file, visually select all, and auto-indent


### Macros

Macros in Vim allow you to record a sequence of commands and play them back, making them incredibly useful for repetitive tasks. Here's how to use them:

#### Recording a Macro
1. Press `q` followed by a letter (a-z) to start recording. For example, `qa` starts recording to register 'a'.
2. Perform the series of commands you want to record.
3. Press `q` again to stop recording.

#### Playing a Macro
- To play a recorded macro, use `@` followed by the register letter. For example, `@a` plays the macro recorded in register 'a'.
- To repeat the last played macro, use `@@`.

#### Repeating Macros
- To play a macro multiple times, use a number before `@`. For example, `5@a` will play macro 'a' five times.

#### Editing Macros
- You can edit a recorded macro by yanking it to a register, editing it in a buffer, and yanking it back:
  1. `"ap` to paste the contents of macro 'a'
  2. Edit the macro
  3. `"ay$` to yank the edited macro back into register 'a'

#### Example Macro
Let's say you want to surround each word in a list with quotes and add a comma:

1. Move cursor to the first word
2. Start recording: `qa`
3. Perform these actions:
   - `ciw""<Esc>P`: Change inner word, type quotes, exit insert mode, paste the word between quotes
   - `A,<Esc>`: Append a comma at the end
   - `j0`: Move to the beginning of the next line
4. Stop recording: `q`

Now you can apply this macro to each subsequent line with `@a`.

#### Tips for Effective Macro Use
- Start and end your macros in a consistent cursor position (like the start of a line) for easier repetition.
- Use movements that will work across multiple lines (like `j` for next line) instead of absolute line numbers.
- Test your macro on different parts of your text to ensure it works as expected before applying it widely.
- Remember that macros simply replay your keystrokes, so they can include not just editing commands, but also movements, searches, or even other macros.

Mastering macros can significantly speed up repetitive editing tasks, making them an essential tool in any Vim user's toolkit.


### Project wide search and replace
1. live grep
2. ctrl+q - to qickfix list
3. :cfdo %s/find/replace/g | update | bd
