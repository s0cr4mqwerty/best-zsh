# ==========================================
# 1. Zinit (Plugin Manager)
# ==========================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# ==========================================
# 2. Historial
# ==========================================
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY          # Comparte historial entre sesiones abiertas
setopt HIST_IGNORE_ALL_DUPS   # Elimina duplicados previos al guardar
setopt HIST_REDUCE_BLANKS     # Remueve espacios innecesarios
setopt HIST_IGNORE_SPACE      # No guarda comandos que inicien con espacio

# ==========================================
# 3. Inicialización del Sistema de Completado
# ==========================================
# Requerido antes de cargar fzf-tab para que Tab funcione
autoload -Uz compinit
compinit
zinit cdreplay -q

# ==========================================
# 4. Plugins (Orden Crítico de Carga)
# ==========================================
# 4.1 Completions y FZF-Tab primero
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# 4.2 Autosuggestions (predicciones en gris)
zinit light zsh-users/zsh-autosuggestions

# 4.3 History Substring Search (búsqueda con flechas)
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# 4.4 Syntax Highlighting (SIEMPRE al final de los plugins)
zinit light zdharma-continuum/fast-syntax-highlighting

# ==========================================
# 5. Keybindings
# ==========================================
bindkey -e                    # Modo Emacs por defecto
bindkey '^e' autosuggest-accept
bindkey '^ ' autosuggest-accept  # Ctrl + Espacio para aceptar sugerencias
bindkey '^f' forward-word

# ==========================================
# 6. Integración de Herramientas CLI Modernas
# ==========================================
# zoxide (cd inteligente: úsalo con "z <carpeta>")
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

# ==========================================
# 7. Starship Prompt
# ==========================================
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi