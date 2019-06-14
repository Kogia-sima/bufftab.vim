# Bufftab.vim

[![GitHub license](https://img.shields.io/github/license/Kogia-sima/bufftab.vim.svg)](https://github.com/Kogia-sima/bufftab.vim/blob/master/LICENSE.txt)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat)](http://makeapullrequest.com)
[![GitHub last commit](https://img.shields.io/github/last-commit/Kogia-sima/bufftab.vim.svg?style=flat)](https://github.com/Kogia-sima/bufftab.vim/commits/master)

Replace Vim tabs to buffer list, handle buffers more flexibly, and make sub-windows (e.g. NERDTree) keep visible for all tabs.

:warning: This plugin is still unstable. If you found a bug, feel free to create an issue or pull request.

## Features

- Highly customizable (you can define original functions to handle buffers and tabs)
- Many functions for buffer navigation
- Replace the builtin tabs with original buffer lists
- Using original cache system (which means faster, low cpu usage)
- Keep sub-windows visible for all tabs, including: 
- No additional feature is required (all scripts written with Vim script)

## Installation

### Pathogen

```console
$ git clone https://github.com/Kogia-sima/bufftab.vim ~/.vim/bundle/bufftab.vim
```

### NeoBundle

```vim
NeoBundle 'Kogia-sima/bufftab.vim'
```

### Vundle

```vim
Plugin 'Kogia-sima/bufftab.vim'
```

### Plug

```vim
Plug 'Kogia-sima/bufftab.vim'
```

### Dein

```vim
call dein#add('Kogia-sima/bufftab.vim')
```

### Dein (toml)

```toml
[[plugins]]
repo = 'Kogia-sima/bufftab.vim'
```

### Manual Install

Copy all files in this repocitory into `~/.vim/`

## Configuration

See `:h bufftab-settings`
