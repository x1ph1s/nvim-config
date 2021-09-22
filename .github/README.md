# x1ph1s's neovim configuration
> A neovim configuration

## Installation
[fzf](https://github.com/junegunn/fzf) and [ccls](https://github.com/MaskRay/ccls) need to be installed.
```ssh
git clone --recursive https://github.com/x1ph1s/.vim ~/.config/nvim  # the plugins are submodules
```
***You may want to backup you old neovim configuration:***
```ssh
mv ~/.config/nvim ~/.config/nvim.backup
```

## Usage
Just start neovim. You can update the plugins with ```:PluginUpdate```.

## Features
- Sensible remapped default neovim actions:
    - \<leader> is set to \<space>
    - jk: Leave insert mode
- \<leader>f: **F**u**Z**zy **F**ind files
- \<leader>w: Smart window change ([window-changing.vim](../helper/window-changing.vim))
- \<leader>q: Toggles the quickfix window ([quickfix.vim](../helper/quickfix.vim))
- \<leader>dd: Gdb debugger
- \<F8>: Building with [Dispatch](https://github.com/tpope/vim-dispatch)
- \<F6>: Running (runs .vimrun file)
- Autocomple with [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) and [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
  - [ccls](https://github.com/MaskRay/ccls) for c/c++/objc
- see [vim-helpers](../helper) and [init.vim](../init.vim) for more

### Plugins
Plugins are managed with [pathogen](https://github.com/tpope/vim-pathogen) and git-submodules.
See in [bundle](../bundle) for installed plugins.
