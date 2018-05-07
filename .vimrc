call plug#begin('~/.vim/plugged')
Plug 'https://github.com/lervag/vimtex.git' 
call plug#end()

"VimTeX vars
let g:vimtex_view_method = 'zathura'


"LaTeX quick export
autocmd FileType tex map <F5> <esc>:w<bar>:silent exec "!latexmk -pdf % -interaction=nonstopmode"<bar>:redraw!<CR>
autocmd FileType tex map <C-F5> <esc>:w<bar>!latexmk -pdf %<CR>
autocmd FileType tex map <F6> <esc>:w<bar>!latexmk -pdf % -interaction=nonstopmode;zathura %:r".pdf" &<CR><CR>
autocmd FileType tex imap <F5> <esc>:w<bar>:silent exec "!latexmk -pdf % -interaction=nonstopmode"<bar>:redraw!<CR>i
autocmd FileType tex imap <C-F5> <esc>:w<bar>!latexmk -pdf %<CR>
autocmd FileType tex imap <F6> <esc>:w<bar>!latexmk -pdf % -interaction=nonstopmode;zathura %:r".pdf" &<CR><CR>
"LaTeX commands
autocmd FileType tex map <C-4> i"$$"<Left>
autocmd FileType tex imap <C-4> "$$"<Left>

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
