if v:version < 700
  finish
endif

" Only do this when not done yet for this buffer
if (exists("b:did_php_balloon"))
  finish
endif
let b:did_php_balloon = 1

if !exists('g:php_balloon_php_exec')
  let g:php_balloon_php_exec = 'php'
endif

" To activate, :set ballooneval
if has('balloon_eval') && exists('+balloonexpr')
  setlocal balloonexpr=PhpBalloonexpr()
endif

function! PhpBalloonexpr()
  if executable(eval('g:php_balloon_php_exec'))
    let type = synIDattr(synID(v:beval_lnum, v:beval_col, 1), "name")

    if type == 'phpFunctions'
      return system(g:php_balloon_php_exec . ' --rf ' . v:beval_text)
    elseif type == 'phpClasses'
      return system(g:php_balloon_php_exec . ' --rc ' . v:beval_text)
    endif
  endif

  return ""
endfunction
