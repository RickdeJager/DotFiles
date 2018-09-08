call plug#begin('~/.vim/plugged')
Plug 'https://github.com/lervag/vimtex.git' 
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/JamshedVesuna/vim-markdown-preview'
Plug 'https://github.com/scrooloose/nerdtree'
call plug#end()

"Airline
let g:airline_powerline_fonts = 1
"
"Nerd Tee
map <C-n> :NERDTreeToggle<CR>

"VimTeX vars
let g:vimtex_view_method = 'zathura'
"vim-markdown vars
let vim_markdown_preview_temp_file=0
let vim_markdown_preview_github=1

"LaTeX quick export
autocmd FileType tex map <F5> <esc>:w<bar>:silent exec "!latexmk -pdf % -interaction=nonstopmode"<bar>:redraw!<CR>
autocmd FileType tex map <C-F5> <esc>:w<bar>!latexmk -pdf %<CR>
autocmd FileType tex map <F6> <esc>:w<bar>!latexmk -pdf % -interaction=nonstopmode;zathura %:r".pdf" &<CR><CR>
autocmd FileType tex imap <F5> <esc>:w<bar>:silent exec "!latexmk -pdf % -interaction=nonstopmode"<bar>:redraw!<CR>i
autocmd FileType tex imap <C-F5> <esc>:w<bar>!latexmk -pdf %<CR>
autocmd FileType tex imap <F6> <esc>:w<bar>!latexmk -pdf % -interaction=nonstopmode;zathura %:r".pdf" &<CR><CR>
"LaTeX commands
autocmd FileType tex map <C-c> <esc>0I%<esc>

"Python specific
autocmd FileType python map <F5> <esc>:w<bar>:!clear;python3 %<CR>
autocmd FileType python map <C-c> <esc>0I#<esc>


"Line numbers
:set number relativenumber
"ColorScheme
:colorscheme slate
"spell check
:map <F7> <esc>:set spell! spelllang=en_us<CR>
:imap <F7> <esc>:set spell! spelllang=en_us<CR>i
"Fix wrapping
:set breakindent
"Display tabs v spaces
:set listchars=tab:>-
:nmap <F8> :set invlist<cr>

"Allows me to be lazy
:command WQ wq
:command Wq wq
:command W w
:command Q q
