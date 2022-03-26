let curDir=expand("<sfile>:p:h")."/"
exec "source " . g:curDir ."common_util.vim"

"this is a script to mark keywords from the log file

let IFS = ":"

" term  : vt100, xterm
" cterm : MS-DOS console, color-xterm

" *cterm-colors*
" NR-16　NR-8　　COLOR NAME
" 0 　　　0 　　　 Black
" 1 　　　4 　　　 DarkRed
" 2　　　 2 　　　 DarkGreen
" 3　　　 6 　　　 Brown, DarkYellow
" 4　　　 1 　　　 DarkBlue
" 5　　　 5 　　　 DarkMagenta
" 6　　　 3 　　　 DarkCyan
" 7　　　 7 　　　 LightGray, LightGrey, Gray, Grey
" 8　　　 0*　　　 DarkGray, DarkGrey
" 9　　　 4*　　　 Red, LightRed
" 10　　　2*　　　 Green, LightGreen
" 11　　　6*　　　 Yellow, LightYellow
" 12　　　1*　　　 Blue, LightBlue
" 13　　　5*　　　 Magenta, LightMagenta
" 14　　　3*　　　 Cyan, LightCyan
" 15　　　7*　　　 White

highlight ErroColor cterm=bold ctermfg=Red
			\ ctermbg=Black guifg=Red    guibg=Black
highlight InfoColor cterm=bold ctermfg=Green
			\ ctermbg=Black guifg=Green  guibg=Black
highlight WarnColor cterm=bold ctermfg=Yellow
			\ ctermbg=Black guibg=Yellow guibg=Black

"default keywords list
let g:defaultErroKeyword = "error:err:fail:failed:exception"
let g:defaultInfoKeyword = "info:config:sdaf:a.d"
let g:defaultWarnKeyword = "warn"
let g:defaultIgnoreExtension="c:cc:cpp:h:asm:java:ts:js:html:css:py:yang"

function MatchAdd(keyword_list, color)
    let keyword_list_regexp = GetRegexp(a:keyword_list, g:IFS)
    for keyword_name in split(keyword_list_regexp, g:IFS)
        call matchadd(a:color, keyword_name)
    endfor
endfunction

function! CustomMark()
    let ignoreFileExtension =
		\GetEnvVariable(g:defaultIgnoreExtension, $MARK_IGNORE_FILE_EXTENSION)
    let ret = CheckFileExtension(l:ignoreFileExtension)
    if (len(ret) <= 0)
        return 0
    endif

    " mark for info
    let keywordList =
			\GetEnvVariable(g:defaultInfoKeyword, $MARK_KEYWORD_LIST_INFO)
    call MatchAdd(split(keywordList, g:IFS), 'InfoColor')

    " mark for error
    let keywordList =
			\GetEnvVariable(g:defaultErroKeyword, $MARK_KEYWORD_LIST_ERRO)
    call MatchAdd(split(keywordList, g:IFS), 'ErroColor')

    " mark for warn
    let keywordList =
			\GetEnvVariable(g:defaultWarnKeyword, $MARK_KEYWORD_LIST_WARN)
    call MatchAdd(split(keywordList, g:IFS), 'WarnColor')
endfunction

call CustomMark()

let file_name = expand('%:t:r')
