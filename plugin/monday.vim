" Vim plugin file
"
" Maintainer:   Stefan Karlsson <stefan.74@comhem.se>
" Last Change:  6 May 2005
"
" Purpose:      To make <ctrl-a> and <ctrl-x> operate on the names of weekdays
"               and months. Also to make them operate on text such as 1st, 2nd,
"               3rd, and so on.
"
" TODO:         Although it is possible to add any words you like as
"               increase/decrease pairs, problems will arise when one word has
"               two or more possible successors (or predecessors). For instance,
"               the 4th month is named "April" in both English and Swedish, but
"               its successor is called "May" and "Maj", respectively.
"
"               So, in order for the script to be generally applicable, I must
"               find a way to toggle between all possible increments/decrements
"               of a word.


if exists('loaded_monday') || &compatible
  finish
endif
let loaded_monday = 1

nnoremap <Plug>(monday-increase) :<C-u>call monday#increase()<CR>
nnoremap <Plug>(monday-decrease) :<C-u>call monday#decrease()<CR>
