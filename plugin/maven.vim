let curDir=expand("<sfile>:p:h")."/"
exec "source " . g:curDir ."common_util.vim"

let g:defaultBuildCmd="mvn compile -Dskiptests"

" build spring project
"   find directory which have pom.xml file
"   from current to parent and compile
function! BuildSpringProject()
    let curDir=getcwd()
    let files=globpath(l:curDir, 'pom.xml')
    while(len(l:files) == 0)
        let curDirList=split(l:curDir, "/")
        if (len(l:curDirList) == 0)
            break
        endif
        call remove(curDirList, -1)
        call insert(curDirList, "", 0)
        let curDir=join(curDirList, "/")
        let files=globpath(curDir, 'pom.xml')
    endwhile

    if (len(l:files) >= 0 && len(l:curDir) != 0)
        let buildCmd = GetEnvVariable(g:defaultBuildCmd, $MAVEN_BUILD_CMD)
        echo l:curDir
        exe "!cd " . l:curDir ." && ".buildCmd
    endif
    unsilent
endfunction
