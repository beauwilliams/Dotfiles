
"===========================KEY MAPPINGS===============================
   "____    __  __    ____   ______    __ __          ______   __  __    ____    ____     ______
  "/ __ \  / / / /   /  _/  / ____/   / //_/         / ____/  / / / /   /  _/   / __ \   / ____/
 "/ / / / / / / /    / /   / /       / ,<           / / __   / / / /    / /    / / / /  / __/
"/ /_/ / / /_/ /   _/ /   / /___    / /| |         / /_/ /  / /_/ /   _/ /    / /_/ /  / /___
"\___\_\ \____/   /___/   \____/   /_/ |_|         \____/   \____/   /___/   /_____/  /_____/


"+++++++BASIC NAVIGATION+++++++
"
"LEADER <leader> key is SPACE
"
"ENTER COMMAND MODE QUICKLY
"Mapping -> <leader><leader> (Hit Space Twice)
"
"ENTER NORMAL MODE QUICKLY
"Mapping -> jj (hit j twice)
"
"VIM COMMANDS CHEATSHEET / HELP MENU
"<leader>?
"
"VIM CONTROL P LIKE MENU (FUZZYMENU)
"<leader>p
"
"DITCH THOSE ARROW KEYS --> MOVE UP AND DOWN *IN INSERT MODE* WITH HJKL BY SIMPLY HOLDING CONTROL
"Mapping -> <c-h> --> move left
"Mapping -> <c-j> --> move down
"Mapping -> <c-k> --> move up
"Mapping -> <c-l> --> move right




"++++++++WINDOW NAVIGATION+++++++
"
"Open new splits, use leader + hjkl to specify which direction you want to create the
"split (up, down, let, right)
"Mapping -> <leader>h <leader>j .. etc
"
"Cycle between spilts/[w]indows in a clockwise motion, *hold shift key for anticlockwise
"Mapping -> <leader>w
"
"CHANGE A SPLIT ORENTATION FROM HORIZONTAL TO VERTICAL AND VICE VERSA
"Mapping -> <leader>[ & <leader>]




"++++++++FILE NAVIGATION AND FUZZY SEARCH++++++++
"
"Open file tree to [n]avigate files
"Mapping -> <leader>n
"
"[s]earch for files by filename in the current working directory
"Mapping -> <leader>s
"
"Search for content/strings within [f]iles in the current directory
"Mapping -> <leader>f
"
"List current [b]uffers and search by buffer filenames
"Mapping -> <leader>b
"
"List previously visited file history and [S]earch by filename
"Think s to search files, and shift+s to search file history
"Mapping -> <leader>S
"
"List ALL Possible [c]ommand Mode Commands, Search and Execute Them
"Mapping -> <leader>c




"++++++++CODE NAVIGATION AND RELATED TOOLS++++++++
"
"DIAGNOSTICS NAVIGATION
"Mapping -> [g
"Mapping -> ]g
"Use Command `:CocDiagnostics` to get all diagnostics of current buffer in location list.

"GO TO CODE NAVIGATION.
"Mapping -> gd --> Go to Definition
"Mapping -> gy --> Got to Type Definition
"Mapping -> gi --> Go to Implementation
"Mapping -> gr --> Go to References

"DOCUMENTATION VIEIWING
"Use K to show documentation in preview window.




"++++++++CODE REFACTORING AND RELATED TOOLS++++++++
"
"FIND AND REPLACE
"REPLACE ALL WORDS QUICKLY WITH SHIFT+R
"OR........
"Replace/Delete words quick! ONE BY ONE.
"*NOTE* You must first search for a string and have it highlighted first [can use SHIFT+R as above] before we can change and delete based on that pattern
"after searching for a word, use c for CHANGE & d for DELETE. We use , . to move back and forth between matches respectively
"Mapping -> c.
"Mapping -> c,
"Mapping -> d.
"Mapping -> d,
"NOTE: CLEAR HIGHLIGHTS WITH <leader>/
"
"QUICK COMMENTING
"NOTE: It is actually ++ but I used a trick for my mac to map that key to ++ in iterm
"Mapping -> cmd+/




"++++++++CODE FORMATTING AND RELATED TOOLS++++++++
"
"Remove indents from code! (a simple code formatter)
"Mapping -> <leader>i
"
"[F]ormat code
"Mapping -> <leader>F
"
"Remove superfluous [w]hitespaces at the end of lines
"Mapping -> <leader>W




"++++++++HANDY COMMANDS++++++++
"
"Speeding up auto correction toggle for my uni lectures
"Also spellchecking using native neovim
"Note plgn is Vim-you-autocorrect
"Command -> spellon
"Command -> spelloff
"Command -> spellcheck
"[s  -> go to previous spell error
"]s  -> go to next spell error
"zg  -> add word to dictionary
"z=  -> pop up list of word corrections/suggestions
"1z= -> correct spelling using first given suggestion
