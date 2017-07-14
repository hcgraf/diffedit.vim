# diffedit.vim
Some commands to help editing diff/patch files with vim

## Requirements

[vim-textobj-diff](https://github.com/kana/vim-textobj-diff) (requires [vim-textobj-user](https://github.com/kana/vim-textobj-user) in turn).

## Usage

Only useful with two diff-files opened in two splits.  
This plugin will assume splits, it doesn't do any checking for now. Without splits, strange things might happen.
It does in general very little error checking for now.

## Mappings

All the mappings are only active in normal mode, and work on the file/hunk the cursor is currently in.

`<Leader>hp` previous hunk

`<Leader>hn` next hunk

`<Leader>fp` previous file (within diff-file)

`<Leader>fn` next file (within diff-file)

`<Leader>hc` copy hunk to the other split

`<Leader>hm` move hunk to the other split

`<Leader>hd` delete current hunk

`<Leader>fc` copy file to the other split

`<Leader>fm` move file to the other split

`<Leader>fd` delete current file (within diff-file)
