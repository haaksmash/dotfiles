setopt no_beep # don't beep on error
setopt interactive_comments # Allow comments even in interactive shells
bindkey -v # Vim is king, Vim is life
bindkey -M viins 'jj' vi-cmd-mode
bindkey "^R" history-incremental-search-backward

# ===== Navigation
setopt pushd_ignore_dups

# ===== Completion
setopt always_to_end # When completing from the middle of a word, move the cursor to the end of the word 
setopt auto_menu # show completion menu on successive tab press. needs unsetop menu_complete to work
setopt auto_name_dirs # any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
setopt complete_in_word # Allow completion from within a word/phrase

unsetopt menu_complete # do not autoselect the first completion entry

# ===== Prompt
setopt prompt_subst
