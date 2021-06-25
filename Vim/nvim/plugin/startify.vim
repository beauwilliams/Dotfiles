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
let g:session_autosave = 'no'
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1


let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Recent Files']                 },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']                     },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']                    },
          \ ]

let g:startify_bookmarks = [
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


