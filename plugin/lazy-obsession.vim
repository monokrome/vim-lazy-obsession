if exists('g:loaded_lazy_obsession')
  finish
endif

let g:loaded_lazy_obsession = 1

if !exists('g:sessions_root')
  if has('win32') || has('win64')
    let s:vim_home = expand($HOME . '/vimfiles')
  else
    let s:vim_home = expand($HOME . '/.vim')
  endif

  let g:sessions_root = expand(s:vim_home . '/sessions')
endif

function! LoadSession()
  if argc() > 0
    return
  endif

  let b:session_directory = g:sessions_root . getcwd()
  let b:session_filename = b:session_directory . '/Session.vim'

  if filereadable(b:session_filename)
    execute 'source ' b:session_filename
  else
    if !isdirectory(b:session_directory) && !filereadable(b:session_directory)
      call mkdir(b:session_directory, 'p')
    endif

    if !filereadable(b:session_filename)
      execute 'Obsession ' b:session_filename
    else
      execute 'source ' b:session_filename
    endif
  endif
endfunction

autocmd VimEnter * nested :call LoadSession()
