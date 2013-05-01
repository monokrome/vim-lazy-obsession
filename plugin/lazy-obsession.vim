if exists('g:loaded_lazy_obsession')
  finish
endif

let g:loaded_lazy_obsession = 1

if !exists('g:sessions_root')
  let g:sessions_root = expand($HOME . '/.vim/sessions')
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

