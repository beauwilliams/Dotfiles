scriptencoding utf-8

if exists('g:loaded_repo_edit') || &compatible
  finish
endif

let g:loaded_git_viewer = 1

function! GitRepoQuickView(url) abort
	let l:basename = system("basename " . a:url . " .git")
	let l:repo_path = fnamemodify(tempname(),':h') . "/" . l:basename
	execute "!git clone " . a:url . " " . l:repo_path
	execute "lcd ". l:repo_path
	edit .
endfunction

command! -nargs=1 GitRepoQuickView call GitRepoQuickView(<q-args>)
command! -nargs=1 GQuickView call GitRepoView(<q-args>)
