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

  let b:session_filename = 'Session.vim'
  let b:session_path = b:session_directory . '/' . b:session_filename

  if isdirectory(b:session_directory)
    if !isdirectory(b:session_directory) && !filereadable(b:session_directory)
      call mkdir(b:session_directory, 'p')
    endif

    if !filereadable(b:session_path)
      execute 'Obsession ' . b:session_path
    else
      execute 'source ' . b:session_path
    endif
  endif

  if filereadable(b:session_path)
    execute 'source ' b:session_path
  endif
endfunction

autocmd VimEnter * nested :call LoadSession()
