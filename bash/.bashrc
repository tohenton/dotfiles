# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Disable appending the command history list into the history ile on session closing
shopt -u histappend

# Sync the command history list and the history file
function sync_history {
    history -a  # Append the command history list into the history file
    history -c  # Clear the command history list
    history -r  # Reload the command history list from the history file
}
PROMPT_COMMAND=sync_history  # Execute sync_history right before primary prompt


# Expand history size
HISTSIZE=1000000
HISTFILESIZE=20000
