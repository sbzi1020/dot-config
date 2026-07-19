" ===========================================================
" Colemak navigation
" ===========================================================

" Base movement
noremap j j
noremap k k
noremap h h
noremap l l

" Line movement (go to start of line and end of line)
"noremap M ^
"noremap I $

" Edit
"noremap l i
"noremap L I



" ===========================================================
" Normal binding
" ===========================================================
" Save and quit
noremap W :w<CR>
noremap Q :q<CR>


" ===========================================================
" Vim settings
" ===========================================================
" Yank to system clipboard
set clipboard=unnamed

" Indent
set tabstop=4

" " Quickly remove search highlights
" "nmap <F9> :nohl




" " Go back and forward with Ctrl+O and Ctrl+I
" " (make sure to remove default Obsidian shortcuts for these to work)
" exmap back obcommand app:go-back
" nmap <C-o> :back
" exmap forward obcommand app:go-forward
" nmap <C-i> :forward
