"=============================================================================
" FILE: bufftab.vim
" AUTHOR:  Kogia-sima <orcinus4627@gmail.com>
" License: MIT license
"=============================================================================

scriptencoding utf-8

if exists('g:loaded_bufftab')
  finish
endif
let g:loaded_bufftab = 1

if v:version < 700
  echoerr printf('Vim >= 7 is required for bufftab (this is only %d.%d)',v:version/100,v:version%100)
  finish
endif

hi default link BuffTabCurrent TabLineSel
hi default link BuffTabActive  PmenuSel
hi default link BuffTabHidden  TabLine
hi default link BuffTabFill    TabLineFill

let g:bufftab_numbers    = get(g:, 'bufftab_numbers',    0)
let g:bufftab_indicators = get(g:, 'bufftab_indicators', 1)
let g:bufftab_autoclose = get(g:, 'bufftab_autoclose', 1)

augroup BuffTab
  autocmd!
  autocmd VimEnter  * call bufftab#init()
  "autocmd TabEnter  * call bufftab#update()
  autocmd BufAdd    * call bufftab#update(0, 1)
  autocmd BufDelete * call bufftab#update()
  autocmd BufRead * call bufftab#update(1, 1)

  if g:bufftab_indicators
    autocmd TextChanged,TextChangedI,BufWritePost * call bufftab#update(1)
  endif
augroup END


nmap <silent> <Plug>(bufftab_next) :<C-U>call bufftab#next()<CR>
nmap <silent> <Plug>(bufftab_previous) :<C-U>call bufftab#previous()<CR>
nmap <silent> <Plug>(bufftab_close) :<C-U>call bufftab#close()<CR>
imap <silent> <Plug>(bufftab_next) <C-o>:call bufftab#next()<CR>
imap <silent> <Plug>(bufftab_previous) <C-o>:call bufftab#previous()<CR>
imap <silent> <Plug>(bufftab_close) <C-o>:call bufftab#close()<CR>
