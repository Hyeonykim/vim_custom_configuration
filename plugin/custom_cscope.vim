" {{{
"		Description: Load cscope.out files
"		Environment Variable:
"			- CSCOPE_DB_PATHS: path for cscope.out
"			- CSCOPE_ROOT_PATH_KEYWORDS: subdirectories of the root directory
" }}}

const __CS_CMD = "cscope"
const __CS_ADD = __CS_CMD . " add"
const __CS_KILL = __CS_CMD . " kill"
const __CS_DB_NAME = "cscope.out"
const __CS_CWD = '/' . fnamemodify(getcwd(), ':t')
const __DEFAULT_KEYWORDS = g:__CS_CWD
const __DEFAULT_DB_PATHS = g:__CS_CWD . ",none"
const __LOG_PRINT = 1
const __LOG_RETURN = 0

function! __ExecuteCommand(command, log)
	if (a:log == g:__LOG_RETURN)
		 return execute(join(a:command, " "))
	elseif (a:log == g:__LOG_PRINT)
		execute(join(a:command, " "))
	endif
endfunction

function! __IsFile(path)
	let is_file = 0
	if filereadable(expand(a:path))
		let is_file = 1
	endif

	return l:is_file
endfunction

function! __GetEnvVariable(
			\environment_variable,
			\default_variable,
			\seperator = ":")

	let target_environment_variable =
				\split(a:environment_variable, a:seperator)
	if (empty(target_environment_variable))
		let target_environment_variable =
					\split(a:default_variable, a:seperator)
	endif

	return target_environment_variable
endfunction

function! __GetDefaultKeywords()
	return __GetEnvVariable(
				\$CSCOPE_ROOT_PATH_KEYWORDS,
				\g:__DEFAULT_KEYWORDS)
endfunction

function! __GetDbPaths()
	return __GetEnvVariable($CSCOPE_DB_PATHS, g:__DEFAULT_DB_PATHS)
endfunction

function! __FilterRelativePath(keyword)
	let candidate_paths = __GetDbPaths()
	let filtered_paths = []

	for relative_path_with_keyword in l:candidate_paths
		let relative_path = split(relative_path_with_keyword, ",")[0]
		let relative_path_keyword = split(relative_path_with_keyword, ",")[1]

		let is_valid = "false"
		if (a:keyword == "*")
			let l:is_valid = "true"
		elseif (a:keyword == l:relative_path_keyword)
			let l:is_valid = "true"
		endif

		if (l:is_valid == "true")
			call add(l:filtered_paths, l:relative_path)
		endif
	endfor

	return l:filtered_paths
endfunction

function! __GetRootPath()
	const keywords = __GetDefaultKeywords()

	let root_path = getcwd()
	for keyword_name in keywords
		let index = match(root_path, keyword_name)
		if (index != -1)
			let root_path = strpart(root_path, 0, index)
			break
		endif
	endfor

	return root_path
endfunction

function! __ExtractAddedDbPaths()
	const path_index = 2
	let db_raw_data = __ExecuteCommand(["cs show"], g:__LOG_RETURN)
	let dbs = split(l:db_raw_data, '\n')
	let added_dbs = []

	for db in l:dbs
		if len(db) == 0
			continue
		endif

		let db_path = split(db)[l:path_index]

		call add(added_dbs, db_path)
	endfor

	return added_dbs
endfunction

function! KillCscopeDbs()
	let dbs = __ExtractAddedDbPaths()

	for db in l:dbs
		if !__IsFile(db)
			continue
		endif

		let kill_cmd = [g:__CS_KILL, db]

		call __ExecuteCommand(kill_cmd, g:__LOG_PRINT)
	endfor
endfunction

function! __LoadCscopeDbs(keyword="*")
	const root_path = __GetRootPath()
	const relative_paths = __FilterRelativePath(a:keyword)

	for relative_path in relative_paths
		let db_path = root_path . relative_path . g:__CS_DB_NAME
		let add_cmd = [g:__CS_ADD, l:db_path, l:db_path]

		if (!filereadable(db_path))
			continue
		endif

		set nocscopeverbose
		call __ExecuteCommand(add_cmd, g:__LOG_PRINT)
		set cscopeverbose
	endfor
endfunction

function! LoadCscope(keyword="*")
	if !has(g:__CS_CMD)
		return
	endif

	call __LoadCscopeDbs(a:keyword)
endfunction

call LoadCscope() "Execute LoadCscope() when the vim executed
