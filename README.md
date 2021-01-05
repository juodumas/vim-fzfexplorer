# vim-fzfexplorer

A minimal VIM file explorer plugin using FZF to quickly open files from current
directory. This is my attempt to migrate from the great
https://github.com/sjbach/lusty to FZF.

Depends on https://github.com/junegunn/fzf. Add this to your .vimrc to install
using https://github.com/junegunn/vim-plug:

    Plug 'junegunn/fzf'
    Plug 'juodumas/vim-fzfexplorer'

Call `:FZFExplore` to open the explorer:

    :FZFExplore <dir>

Map to `<Leader>e` to start browsing from current directory:

    nmap <silent> <Leader>e :FZFExplore<CR>


Map to `<Leader>r` to start browsing from current file's directory:

    nmap <silent> <Leader>r :execute 'FZFExplore ' . expand('%:p:h')<CR>

