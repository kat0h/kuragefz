vim9script

split
enew

var dirlist = readdir(expand("~/dev/vim/vim"))
append(0, ['', ''])
append(2, dirlist[: winheight(0)])
cursor(1, 1)
redraw

var isLoop = true
var inkey = ''
var inword = ''

while isLoop
  inkey = nr2char(getchar())

  # 入力がescなら終了
  if inkey == ''
    isLoop = false

  # 入力がそれ以外ならmatch
  else
    for i in range(winheight(0))
      setline(i + 1, '')
    endfor
    inword = inword .. inkey
    var fuzzyedlist = matchfuzzy(dirlist, inword)
    if len(fuzzyedlist) > 0
      setline(1, inword)
      for i in range(len(fuzzyedlist))
        setline(i + 3, fuzzyedlist[i])
        if i > winheight(0)
          break
        endif
      endfor
    endif
  endif
  redraw
endwhile

finish
