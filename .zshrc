warn_message "Running zshrc...."

# Git branch parser
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%b'

# Command line prompt
PROMPT='%F{cyan}%n%f@%F{cyan}%M%f:%F{green}%~%f %F{red}${vcs_info_msg_0_} $%f '

success_message ".zshrc done"