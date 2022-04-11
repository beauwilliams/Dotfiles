scriptencoding utf-8

if exists('g:loaded_repo_edit') || &compatible
  finish
endif

let g:loaded_git_viewer = 1

function! GitRepoView(url) abort
	let l:basename = system("basename " . a:url . " .git")
	let l:repo_path = fnamemodify(tempname(),':h') . "/" . l:basename
	execute "!git clone " . a:url . " " . l:repo_path
	execute "lcd ". l:repo_path
	edit .
endfunction

command! -nargs=1 GitRepoView call GitRepoView(<q-args>)
command! -nargs=1 GView call GitRepoView(<q-args>)
