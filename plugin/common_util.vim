" function to get environment variable
" return defaultVal if the envVal have no value
function! GetEnvVariable(defaultVal, envVal)
    let retVal = a:envVal
    if (len(a:envVal) <= 0)
        let retVal = a:defaultVal
    else
        let retVal = a:envVal
    endif

    return retVal
endfunction

" function to generate regexp to ignorecase
function! GetIgnoreCaseRegexp(targetStr)
    let lowerStr = tolower(a:targetStr)
    let upperStr = toupper(a:targetStr)
    let regexp = ""
    for idx in range(0, len(a:targetStr) -1)
        "let idx = str2nr(i)
        let regexp = l:regexp."["
        if (a:targetStr[l:idx] == " ")
            let regexp = l:regexp.a:targetStr[l:idx]
        else
            let regexp = l:regexp.lowerStr[l:idx].upperStr[l:idx]
        endif
        let regexp = l:regexp."]"
    endfor

    return l:regexp
endfunction

function! GetRegexp(keywords, ...)
    let arguments = a:
    let index = 1
    let NotFound = 0
    " get argument with index
    let IFS = get(arguments, index, NotFound)
    if (IFS[0] == NotFound[0])
        let IFS = ":"
    endif
    let regexp = ""
    for l:keywordStr in a:keywords
        let regexp = l:regexp.IFS.GetIgnoreCaseRegexp(l:keywordStr)
    endfor
    return l:regexp
endfunction

" function to check supported file extension
"   support         : return file extension
"   not supported   : return empty string("")
function! CheckFileExtension(ignoreExtension)
    let ignoreExtension = a:ignoreExtension
    let ignoreExtension = split(l:ignoreExtension, g:IFS)
    let extension = tolower(expand('%:e'))

    if (index(l:ignoreExtension, l:extension) >= 0)
        let extension = ""
    endif

    return l:extension
endfunction
