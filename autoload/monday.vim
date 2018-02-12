scriptencoding utf-8

function! monday#add_word_pair(word1, word2)
  if a:word1 =~# '[[:alnum:]]\+' && a:word2 =~# '[[:alnum:]]\+'
    " lowercase
    let w10 = tolower(a:word1)
    " Uppercase
    let w11 = toupper(matchstr(a:word1, '.')) . matchstr(w10, '.*', 1) 
    " UPPERCASE
    let w12 = toupper(a:word1)

    let w20 = tolower(a:word2)
    let w21 = toupper(matchstr(a:word2, '.')) . matchstr(w20, '.*', 1) 
    let w22 = toupper(a:word2)

    let g:monday#words = g:monday#words . w10 . ':' . w20 . ','
    let g:monday#words = g:monday#words . w11 . ':' . w21 . ','
    let g:monday#words = g:monday#words . w12 . ':' . w22 . ','
  else
    let g:monday#words = g:monday#words . a:word1 . ':' . a:word2 . ','
  endif
endfunction

function! monday#add_number_suffix(number, suffix)
  let s0 = tolower(a:suffix)
  let s1 = toupper(a:suffix)

  let g:monday#numbers = g:monday#numbers . 's' . a:number . s0 . ','
  let g:monday#numbers = g:monday#numbers . 'l' . a:number . s1 . ','
endfunction

function! monday#find_nr_suffix(w, nr)
  let n1 = matchstr(a:nr, '\d\>')
  let n2 = matchstr(a:nr, '\d\d\>')

  let m = matchstr(a:w, '\D\+', 1)
  let m = matchstr(g:monday#numbers, '[sl]\d\+' . m)
  let m = matchstr(m, '.')

  let c1 = (n1 != "") ? match(g:monday#numbers, m . n1 . '\D\+') : -1
  let c2 = (n2 != "") ? match(g:monday#numbers, m . n2 . '\D\+') : -1

  if c2 >= 0
    return matchstr(g:monday#numbers, '\D\+\>', c2)
  else
    return matchstr(g:monday#numbers, '\D\+\>', c1)
  endif
endfunction

function! monday#increase()
  let N = (v:count < 1) ? 1 : v:count
  let i = 0
  while i < N
    let w = expand('<cword>')
    if g:monday#words =~# '\<' . w . ':'
      let a = matchstr(g:monday#words, w . ':\zs[^,]\+')
      call s:goto_target(w)
      execute 'normal! "_ciw' . a
    elseif w =~# '\<-\?\d\+\D\+\>' && g:monday#numbers =~# '\d\+' . matchstr(w, '\D\+', 1) . ','
      let a = matchstr(w, '-\?\d\+')
      let a = a + 1
      let s = monday#find_nr_suffix(w, a)
      call s:goto_target(w)
      execute 'normal! "_ciW' . a . s
    else
      execute "normal! \<c-a>"
    endif
    let i = i + 1
  endwhile
endfunction

function! monday#decrease()
  let N = (v:count < 1) ? 1 : v:count
  let i = 0
  while i < N
    let w = expand('<cword>')
    if g:monday#words =~# ':' . w . '\>'
      let a = matchstr(g:monday#words, '[^,]\+\ze:' . w)
      call s:goto_target(w)
      execute 'normal! "_ciw' . a
    elseif w =~# '\<-\?\d\+\D\+\>' && g:monday#numbers =~# '\d\+' . matchstr(w, '\D\+', 1) . ','
      let a = matchstr(w, '-\?\d\+')
      let a = a - 1
      let s = monday#find_nr_suffix(w, a)
      call s:goto_target(w)
      execute 'normal! "_ciW' . a . s
    else
      execute "normal! \<c-x>"
    endif
    let i = i + 1
  endwhile
endfunction

function! s:goto_target(target)
  if matchstr(getline('.'), '.', col('.') - 1) =~# '\s'
    call search(a:target)
  endif
endfunction

let g:monday#words = get(g:, 'monday#words', '')
let g:monday#numbers = get(g:, 'monday#numbers', '')

call monday#add_word_pair('monday',    'tuesday')
call monday#add_word_pair('tuesday',   'wednesday')
call monday#add_word_pair('wednesday', 'thursday')
call monday#add_word_pair('thursday',  'friday')
call monday#add_word_pair('friday',    'saturday')
call monday#add_word_pair('saturday',  'sunday')
call monday#add_word_pair('sunday',    'monday')

call monday#add_word_pair('january',   'february')
call monday#add_word_pair('february',  'march')
call monday#add_word_pair('march',     'april')
call monday#add_word_pair('april',     'may')
call monday#add_word_pair('may',       'june')
call monday#add_word_pair('june',      'july')
call monday#add_word_pair('july',      'august')
call monday#add_word_pair('august',    'september')
call monday#add_word_pair('september', 'october')
call monday#add_word_pair('october',   'november')
call monday#add_word_pair('november',  'december')
call monday#add_word_pair('december',  'january')

call monday#add_number_suffix('11', 'th')
call monday#add_number_suffix('12', 'th')
call monday#add_number_suffix('13', 'th')

call monday#add_number_suffix( '0', 'th')
call monday#add_number_suffix( '1', 'st')
call monday#add_number_suffix( '2', 'nd')
call monday#add_number_suffix( '3', 'rd')
call monday#add_number_suffix( '4', 'th')
call monday#add_number_suffix( '5', 'th')
call monday#add_number_suffix( '6', 'th')
call monday#add_number_suffix( '7', 'th')
call monday#add_number_suffix( '8', 'th')
call monday#add_number_suffix( '9', 'th')
