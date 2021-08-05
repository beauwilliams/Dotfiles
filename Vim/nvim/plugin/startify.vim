"==========================START STARTIFY CONFIGS=============================





"let g:startify_custom_header = [
        "\ '   ███╗   ██╗███████╗ ██████╗     ██╗   ██╗██╗███╗   ███╗',
        "\ '   ████╗  ██║██╔════╝██╔═══██╗    ██║   ██║██║████╗ ████║',
        "\ '   ██╔██╗ ██║█████╗  ██║   ██║    ██║   ██║██║██╔████╔██║',
        "\ '   ██║╚██╗██║██╔══╝  ██║   ██║    ╚██╗ ██╔╝██║██║╚██╔╝██║',
        "\ '   ██║ ╚████║███████╗╚██████╔╝     ╚████╔╝ ██║██║ ╚═╝ ██║',
        "\ '   ╚═╝  ╚═══╝╚══════╝ ╚═════╝       ╚═══╝  ╚═╝╚═╝     ╚═╝',
        "\]

"let g:startify_custom_header = [
"\ '    ███████╗██╗   ██╗██████╗     ███╗   ███╗ █████╗ ███╗   ██╗ ██████╗ ',
"\ '    ██╔════╝██║   ██║██╔══██╗    ████╗ ████║██╔══██╗████╗  ██║██╔════╝ ',
"\ '    ███████╗██║   ██║██████╔╝    ██╔████╔██║███████║██╔██╗ ██║██║  ███╗',
"\ '    ╚════██║██║   ██║██╔═══╝     ██║╚██╔╝██║██╔══██║██║╚██╗██║██║   ██║',
"\ '    ███████║╚██████╔╝██║         ██║ ╚═╝ ██║██║  ██║██║ ╚████║╚██████╔╝',
"\ '    ╚══════╝ ╚═════╝ ╚═╝         ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ',
"\]
"

"let g:startify_custom_header = [
"\ '   ███╗   ███╗ █████╗  ██████╗███████╗██╗',
"\ '   ████╗ ████║██╔══██╗██╔════╝██╔════╝██║',
"\ '   ██╔████╔██║███████║██║     ███████╗██║',
"\ '   ██║╚██╔╝██║██╔══██║██║     ╚════██║╚═╝',
"\ '   ██║ ╚═╝ ██║██║  ██║╚██████╗███████║██╗',
"\ '   ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝',
"\]

"try
let g:startify_custom_header = [
\ '   ██╗     ███████╗████████╗███████╗     ██████╗ ███████╗████████╗    ██╗████████╗██╗',
\ '   ██║     ██╔════╝╚══██╔══╝██╔════╝    ██╔════╝ ██╔════╝╚══██╔══╝    ██║╚══██╔══╝██║',
\ '   ██║     █████╗     ██║   ███████╗    ██║  ███╗█████╗     ██║       ██║   ██║   ██║',
\ '   ██║     ██╔══╝     ██║   ╚════██║    ██║   ██║██╔══╝     ██║       ██║   ██║   ╚═╝',
\ '   ███████╗███████╗   ██║   ███████║    ╚██████╔╝███████╗   ██║       ██║   ██║   ██╗',
\ '   ╚══════╝╚══════╝   ╚═╝   ╚══════╝     ╚═════╝ ╚══════╝   ╚═╝       ╚═╝   ╚═╝   ╚═╝',
\]



let g:startify_session_dir = '~/.cache/nvim/.session'
let g:startify_session_persistence = 1
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1
let g:startify_files_number = 10
let g:startify_padding_left = 3
let g:startify_session_number = 10
let g:startify_session_sort = 0 "Sort sessions by modification time (when the session files were written)
" let g:session_autosave = 'yes'


" function! s:list_commits()
"     let git = 'git -C '. getcwd()
"     let commits = systemlist(git .' log --oneline | head -n10')
"     let git = 'G'. git[1:]
"     return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
" endfunction

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Recent Files']                 },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']                     },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']                    },
          \ ]
          " \ { 'header': ['   Commits'],        'type': function('s:list_commits') },

let g:startify_bookmarks = [
            \ { 'n': '~/Dropbox/Software Eng/Workspaces/Neorg/index.norg' },
            \ { 'v': '~/.config/nvim/init.vim' },
            \ { 'z': '~/.zshrc' },
            \ { 's': '~/.ssh/config' },
            \ { 'vn' : '/Users/admin/Library/Caches/Homebrew/neovim--git'}
            \ ]

"let g:startify_session_autoload = 1
"let g:startify_session_delete_buffers = 1
"let g:startify_change_to_vcs_root = 1
"let g:startify_fortune_use_unicode = 1
"let g:startify_session_persistence = 1
"let g:startify_enable_special = 1

"let g:webdevicons_enable_startify = 1

function! StartifyEntryFormat()
        return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
    endfunction

"catch
    ":PlugInstall
    "echo 'Startify not installed.'
"endtry


"===============================END STARIFY CONFIG=================================


