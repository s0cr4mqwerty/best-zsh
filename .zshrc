# 1. Zinit (Plugin Manager)
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# 2. Historial
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY          # Comparte historial entre sesiones abiertas
setopt HIST_IGNORE_ALL_DUPS   # Elimina duplicados previos al guardar
setopt HIST_REDUCE_BLANKS     # Remueve espacios innecesarios
setopt HIST_IGNORE_SPACE      # No guarda comandos que inicien con espacio

# 3. Plugins
# Carga diferida e instantánea
zinit light-mode for \
    zdharma-continuum/fast-syntax-highlighting \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions
# FZF tab completion (previsualización de comandos/archivos al tabular)
zinit light Aloxaf/fzf-tab
# Búsqueda por subcadena en historial con flechas
zinit ice wait'1' lucid
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# 4. Keybindings
bindkey -e                    # Modo Emacs por defecto
bindkey '^e' autosuggest-accept
bindkey '^f' forward-word

# 5. Integración de Herramientas CLI Modernas
# zoxide (cd inteligente)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi
# fzf
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh 2>/dev/null || fzf --shell=zsh 2>/dev/null)"
fi
# eza (reemplazo de ls)
if command -v eza &> /dev/null; then
    alias ls="eza --icons --group-directories-first"
    alias ll="eza -la --icons --octal-permissions --group-directories-first"
    alias tree="eza --tree --icons"
fi
# bat (reemplazo de cat)
if command -v bat &> /dev/null; then
    alias cat="bat --paging=never"
elif command -v batcat &> /dev/null; then
    alias cat="batcat --paging=never"
fi

# 6. Starship Prompt
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi