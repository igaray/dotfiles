function! KBDtouch() 
    let s:h = winheight(0)
    let s:w = winwidth(0)
    
    let s:c = nr2char(getchar())
    
    if     s:c == "1"
        let s:position = [        1,          1]
    elseif s:c == "2"
        let s:position = [        1, s:w * 1/10]
    elseif s:c == "3"
        let s:position = [        1, s:w * 2/10]
    elseif s:c == "4"
        let s:position = [        1, s:w * 3/10]
    elseif s:c == "5"
        let s:position = [        1, s:w * 4/10]
    elseif s:c == "6"
        let s:position = [        1, s:w * 5/10]
    elseif s:c == "7"
        let s:position = [        1, s:w * 6/10]
    elseif s:c == "8"
        let s:position = [        1, s:w * 7/10]
    elseif s:c == "9"
        let s:position = [        1, s:w * 8/10]
    elseif s:c == "0"
        let s:position = [        1, s:w * 9/10]

    elseif s:c == "q"
        let s:position = [s:h * 1/4,          1]
    elseif s:c == "w"
        let s:position = [s:h * 1/4, s:w * 1/10]
    elseif s:c == "e"
        let s:position = [s:h * 1/4, s:w * 2/10]
    elseif s:c == "r"
        let s:position = [s:h * 1/4, s:w * 3/10]
    elseif s:c == "t"
        let s:position = [s:h * 1/4, s:w * 4/10]
    elseif s:c == "y"
        let s:position = [s:h * 1/4, s:w * 5/10]
    elseif s:c == "u"
        let s:position = [s:h * 1/4, s:w * 6/10]
    elseif s:c == "i"
        let s:position = [s:h * 1/4, s:w * 7/10]
    elseif s:c == "o"
        let s:position = [s:h * 1/4, s:w * 8/10]
    elseif s:c == "p"
        let s:position = [s:h * 1/4, s:w * 9/10]

    elseif s:c == "a"
        let s:position = [s:h * 2/4,           1]
    elseif s:c == "s"
        let s:position = [s:h * 2/4, s:w * 1/10]
    elseif s:c == "d"
        let s:position = [s:h * 2/4, s:w * 2/10]
    elseif s:c == "f"
        let s:position = [s:h * 2/4, s:w * 3/10]
    elseif s:c == "g"
        let s:position = [s:h * 2/4, s:w * 4/10]
    elseif s:c == "h"
        let s:position = [s:h * 2/4, s:w * 5/10]
    elseif s:c == "j"
        let s:position = [s:h * 2/4, s:w * 6/10]
    elseif s:c == "k"
        let s:position = [s:h * 2/4, s:w * 7/10]
    elseif s:c == "l"
        let s:position = [s:h * 2/4, s:w * 8/10]
    elseif s:c == "ñ"
        let s:position = [s:h * 2/4, s:w * 9/10]

    elseif s:c == "z"
        let s:position = [s:h * 3/4,          1]
    elseif s:c == "x"
        let s:position = [s:h * 3/4, s:w * 1/10]
    elseif s:c == "c"
        let s:position = [s:h * 3/4, s:w * 2/10]
    elseif s:c == "v"
        let s:position = [s:h * 3/4, s:w * 3/10]
    elseif s:c == "b"
        let s:position = [s:h * 3/4, s:w * 4/10]
    elseif s:c == "n"
        let s:position = [s:h * 3/4, s:w * 5/10]
    elseif s:c == "m"
        let s:position = [s:h * 3/4, s:w * 6/10]
    elseif s:c == ","
        let s:position = [s:h * 3/4, s:w * 7/10]
    elseif s:c == "."
        let s:position = [s:h * 3/4, s:w * 8/10]
    elseif s:c == "-"
        let s:position = [s:h * 3/4, s:w * 9/10]
    endif

    call cursor(s:position)
endfunc

nnoremap <C-z> :call KBDtouch()<CR>

