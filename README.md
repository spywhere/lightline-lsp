# lightline-lsp

This plugin provides neovim's LSP diagnostic indicator for the [lightline](https://github.com/itchyny/lightline.vim) vim plugin.

![screenshot](./screenshot.png)

## Table Of Contents

* [Installation](#installation)
* [Integration](#integration)
* [Configuration](#configuration)
* [License](#license)

## Installation

Install using a plugin manager of your choice, for example:

```viml
" neovim 0.5 or later which support lsp and lua
Plug 'itchyny/lightline.vim'    " Dependency: status line
Plug 'spywhere/lightline-lsp'
```

## Integration

1. Register the components:

```viml
let g:lightline = {}

let g:lightline.component_expand = {
      \  'linter_hints': 'lightline#lsp#hints',
      \  'linter_infos': 'lightline#lsp#infos',
      \  'linter_warnings': 'lightline#lsp#warnings',
      \  'linter_errors': 'lightline#lsp#errors',
      \  'linter_ok': 'lightline#lsp#ok',
      \ }
```

2. Set color to the components:

```viml
let g:lightline.component_type = {
      \     'linter_hints': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }
```

3. Add the components to the lightline, for example to the right side:

```viml
let g:lightline.active = { 'right': [[ 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_hints', 'linter_ok' ]] }
```

## Configuration

##### `g:lightline#lsp#indicator_hints`

The indicator to use when there are hints. Default is `H:`.

##### `g:lightline#lsp#indicator_infos`

The indicator to use when there are infos. Default is `I:`.

##### `g:lightline#lsp#indicator_warnings`

The indicator to use when there are warnings. Default is `W:`.

##### `g:lightline#lsp#indicator_errors`

The indicator to use when there are errors. Default is `E:`.

##### `g:lightline#lsp#indicator_ok`

The indicator to use when there are no diagnostic. Default is `OK`.

##### `g:lightline#lsp#update_in_insert`

Update diagnostic in insert mode. Default is `v:true`.

### Using icons as indicators

If you would like to replace the default indicators with symbols like on the screenshot, then you'll need to ensure you have some "iconic fonts" installed, such as [Font Awesome](https://fontawesome.com). A common alternative is to replace your primary font with one of the [Patched Nerd Fonts](https://github.com/ryanoasis/nerd-fonts), which saves you from having to install multiple fonts.

The following icons from the Font Awesome font are used in the screenshot:

* Hints: [f002](https://fontawesome.com/icons/search)
* Infos: [f129](https://fontawesome.com/icons/info)
* Warnings: [f071](https://fontawesome.com/icons/exclamation-triangle)
* Errors: [f05e](https://fontawesome.com/icons/ban)
* OK: [f00c](https://fontawesome.com/icons/check)

To specify icons in the configuration, use their unicode codes as `"\uXXXX"` (make sure to wrap them in double quotes). Alternatively copy the icons from a font website, or type <kbd>\<C-v\>u\<4-digit-unicode\></kbd> or <kbd>\<C-v\>U\<8-digit-unicode\></kbd> to insert the literal characters.

See the code points here:

* Font Awesome: https://fontawesome.com/icons
* Nerd Fonts: https://github.com/ryanoasis/nerd-fonts#glyph-sets

Here's the configuration snippet used in the screenshot:

```viml
let g:lightline#lsp#indicator_hints = "\uf002"
let g:lightline#lsp#indicator_infos = "\uf129"
let g:lightline#lsp#indicator_warnings = "\uf071"
let g:lightline#lsp#indicator_errors = "\uf05e"
let g:lightline#lsp#indicator_ok = "\uf00c"
```

## Contributes

During the development, you can use the following command to automatically setup
a working configurations to test the plugin against TSServer LSP...

```
make testrun
```

or

```
nvim -u tests/init.lua tests/sample.js
```

## License

Released under the [ISC License](LICENSE)
based on the work by Maxim Baz on [lightline-ale](https://github.com/maximbaz/lightline-ale)
