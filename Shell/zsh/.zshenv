# NOTE: We put this here so that we can load our functions inside scripts
# To run a script with zsh env included either.. include usr/bin/env zsh
# Or run the script with `zsh <script-name.sh>`
# funcs and aliases and other scripts
for file (~/.config/zsh/functions/*); do
  source $file
done
