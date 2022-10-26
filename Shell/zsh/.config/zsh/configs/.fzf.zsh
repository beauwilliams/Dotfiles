# Setup fzf
# ---------
# Auto-completion
# ------------
# Key bindings
# ---------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# TELL FZF TO USE RIPGREP
if type rg &>/dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi


export FZF_DEFAULT_OPTS=' --bind "ctrl-a:select-all,ctrl-d:deselect-all"'
