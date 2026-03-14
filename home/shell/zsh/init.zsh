bindkey -e
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey '^z' undo 

alias -g C='| wl-copy'
alias -g NE='2>/dev/null'

# 启用菜单选择
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# 颜色配置
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 启用补全缓存
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh

# 详细程度
zstyle ':completion:*' verbose true

eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
