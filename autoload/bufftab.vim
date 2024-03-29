"=============================================================================
" FILE: bufftab.vim
" AUTHOR:  Kogia-sima <orcinus4627@gmail.com>
" License: MIT license
"=============================================================================

let s:save_cpo = &cpo
set cpo&vim

let s:dirsep = fnamemodify(getcwd(),':p')[-1:]
let s:show_num = g:bufftab_numbers == 1
let s:show_ord = g:bufftab_numbers == 2
let s:show_mod = g:bufftab_indicators
let s:buffers = {}

function! s:user_buffers() " help buffers are always unlisted, but quickfix buffers are not
  return filter(range(1,bufnr('$')),'buflisted(v:val) && "quickfix" !=? getbufvar(v:val, "&buftype")')
endfunction

function! s:label(path) abort
  return strtrans(pathshorten(fnamemodify(a:path, ':p:~:.')))
endfunction

function! s:is_subwindow(...) abort
  if a:0 == 0
    return (&buftype =~ 'nofile\|quickfix\|help')
  else
    return (getbufvar(a:1, "&buftype") =~ 'nofile\|quickfix\|help')
  endif
endfunction

function! s:get_highlight(bufnum)
  return winbufnr(0) == a:bufnum ? 'Current' : bufwinnr(a:bufnum) > 0 ? 'Active' : 'Hidden'
endfunction

function! bufftab#init()
  call bufftab#update()
  set guioptions-=e
  set showtabline=2
  set tabline=%!bufftab#render()
endfunction

function! bufftab#update(...)
  let current_only = 0
  let force_update = 0

  if a:0 > 0
    let current_only = a:1
  endif

  if a:0 > 1
    let force_update = a:2
  endif

  let bufnums = s:user_buffers()

  if current_only
    let bufnum = winbufnr(0)
    if !has_key(s:buffers, bufnum)
      return
    endif
    if force_update
      let path = bufname(bufnum)
      if isdirectory(path)
        return
      endif
      let s:buffers[bufnum] = {'label': (strlen(path) ? s:label(path) : '[No Name]') . ' ', 'pre': s:show_num ? bufnum : ''}
    endif

    if s:show_mod
      let pre = ( getbufvar(bufnum, '&mod') ? '+' : '' )
      let pre .= s:show_num ? bufnum : ''
      let s:buffers[bufnum].pre = strlen(pre) ? pre . ' ' : ''
    endif
  else
    for bufnum in bufnums
      if !has_key(s:buffers, bufnum) || force_update
        let path = bufname(bufnum)
        if isdirectory(path)
          continue
        endif
        let s:buffers[bufnum] = {'label': (strlen(path) ? s:label(path) : '[No Name]') . ' ', 'pre': s:show_num ? bufnum : ''}
      endif

      if s:show_mod
        let pre = ( getbufvar(bufnum, '&mod') ? '+' : '' )
        let pre .= s:show_num ? bufnum : ''
        let s:buffers[bufnum].pre = strlen(pre) ? pre . ' ' : ''
      endif
    endfor
  endif

  let &tabline=&tabline
endfunction

function! bufftab#render()
  let bufnums = filter(sort(map(keys(s:buffers), 'str2nr(v:val)')),'buflisted(v:val) && "quickfix" !=? getbufvar(v:val, "&buftype")')
  let swallowclicks = '%'.(1 + tabpagenr('$')).'X'

  " " pick up data on all the buffers
  " let buffers = []
  " let currentbuf = winbufnr(0)
  " let screen_num = 0
  " for bufnum in bufnums
  "   let tab = { 'bufnum': bufnum, 'path': bufname(bufnum) }
  "   if isdirectory(tab.path)
  "     continue
  "   endif
  "   let tab.hilite = currentbuf == bufnum ? 'Current' : bufwinnr(bufnum) > 0 ? 'Active' : 'Hidden'
  "   let screen_num = s:show_num ? bufnum : s:show_ord ? screen_num + 1 : ''
  "   if strlen(tab.path)
  "     let tab.label = s:label(tab.path) . ' '
  "     let pre = screen_num . ( s:show_mod && getbufvar(bufnum, '&mod') ? '+' : '' )
  "     let tab.pre = strlen(pre) ? pre . ' ' : ''
  "   else " unnamed file
  "     let tab.label = '[No Name] '
  "   endif
  "   let buffers += [tab]
  " endfor

  return swallowclicks . join(map(bufnums,'"%#BuffTab" . s:get_highlight(v:val) . "# " . s:buffers[v:val].pre . s:buffers[v:val].label'),'') . '%#BufTabLineFill#'
endfunction

" for unittest
function! bufftab#get_bufs() abort
  return filter(copy(s:buffers), 'buflisted(str2nr(v:key))')
endfunction

function! bufftab#next() abort
  if !s:is_subwindow()
    execute "bnext"
  endif
endfunction

function! bufftab#previous() abort
  if !s:is_subwindow()
    execute "bprevious"
  endif
endfunction

function! bufftab#close() abort
  if g:bufftab_autoclose
    let l:bufcount = len(s:user_buffers())
    if l:bufcount <= 1
      execute "quit"
    endif
  endif

  execute "bdelete"
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
