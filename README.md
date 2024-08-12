# Open GitHub Action

Opens the GitHub Action or reusable Workflow source code from Neovim. This is especially useful for reusable workflows in your organization to quickly look at workflow parameters and source code.

[Demo](https://github.com/user-attachments/assets/a129f155-d6d3-4a5c-8a45-ae021525df14)

## Installation

With [lazy.vim](https://github.com/folke/lazy.nvim):

```lua
{
  "amirkarimi/open-github-action.nvim",
  opts = {},
},
```

## Usage

Move the cursor on the GitHub action or reusable workflow name and press `gwx`. It opens the source code in the browser.

