#!/usr/bin/env bash
set -e

# ==========================================
# Colores para la salida en consola
# ==========================================
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}=== Iniciando instalación automatizada del entorno de terminal ===${NC}"

# ==========================================
# 1. Detección del SO e instalación de paquetes
# ==========================================
install_packages() {
    echo -e "${YELLOW}-> Instalando dependencias básicas y utilidades modernas...${NC}"
    if [ -f /etc/arch-release ]; then
        sudo pacman -Syu --noconfirm git curl zsh fzf zoxide eza bat kitty
    elif [ -f /etc/fedora-release ]; then
        sudo dnf install -y git curl zsh fzf zoxide eza bat kitty util-linux-user
    elif [ -f /etc/debian_version ]; then
        sudo apt update
        sudo apt install -y git curl zsh fzf zoxide bat kitty
        
        # eza requiere llave/repo externo en ramas estables antiguas de Debian/Ubuntu
        if ! command -v eza &> /dev/null; then
            sudo mkdir -p /etc/apt/keyrings
            wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg || true
            echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list || true
            sudo apt update && sudo apt install -y eza || true
        fi
    elif [ "$(uname)" = "Darwin" ]; then
        if ! command -v brew &> /dev/null; then
            echo -e "${YELLOW}-> Instalando Homebrew...${NC}"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install git curl zsh fzf zoxide eza bat starship
    else
        echo -e "${RED}-> Distribución no identificada automáticamente. Verifica tener instalados: git, curl, zsh, fzf, zoxide, eza, bat, kitty.${NC}"
    fi
}

install_packages

# ==========================================
# 2. Instalación de Starship Prompt
# ==========================================
if ! command -v starship &> /dev/null; then
    echo -e "${YELLOW}-> Instalando Starship Prompt...${NC}"
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# ==========================================
# 3. Instalación de CaskaydiaCove Nerd Font
# ==========================================
if [ "$(uname)" = "Linux" ]; then
    FONT_DIR="${HOME}/.local/share/fonts"
    if [ ! -d "$FONT_DIR/CascadiaCode" ]; then
        echo -e "${YELLOW}-> Descargando e instalando CaskaydiaCove Nerd Font...${NC}"
        mkdir -p "$FONT_DIR/CascadiaCode"
        curl -fLo /tmp/CascadiaCode.tar.xz https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.tar.xz
        tar -xf /tmp/CascadiaCode.tar.xz -C "$FONT_DIR/CascadiaCode"
        rm /tmp/CascadiaCode.tar.xz
        fc-cache -f "$FONT_DIR" > /dev/null 2>&1 || true
        echo -e "${GREEN}-> Fuente instalada correctamente.${NC}"
    fi
fi

# ==========================================
# 4. Respaldo y Despliegue de Configuraciones
# ==========================================
echo -e "${YELLOW}-> Configurando dotfiles (Zsh, Starship y Kitty)...${NC}"
TIMESTAMP=$(date +%s)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_RAW_URL="https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main"

# Respaldos de archivos previos si ya existen
[ -f "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$HOME/.zshrc.backup.$TIMESTAMP"
[ -f "$HOME/.config/starship.toml" ] && mv "$HOME/.config/starship.toml" "$HOME/.config/starship.toml.backup.$TIMESTAMP"

# Crear directorios de destino
mkdir -p "$HOME/.config/kitty"

# Respaldo y copia de Kitty
if [ -d "$HOME/.config/kitty" ] && [ "$(ls -A "$HOME/.config/kitty" 2>/dev/null)" ]; then
    echo -e "${YELLOW}-> Respaldando configuración existente de Kitty...${NC}"
    mv "$HOME/.config/kitty" "$HOME/.config/kitty.backup.$TIMESTAMP"
    mkdir -p "$HOME/.config/kitty"
fi

if [ -f "$SCRIPT_DIR/.zshrc" ]; then
    # Modo Local (ejecutado desde repositorio clonado)
    cp "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
    cp "$SCRIPT_DIR/starship.toml" "$HOME/.config/starship.toml"
    if [ -f "$SCRIPT_DIR/kitty/kitty.conf" ]; then
        cp "$SCRIPT_DIR/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
    fi
else
    # Modo Remoto (ejecutado mediante 'curl | bash')
    echo -e "${YELLOW}-> Descargando archivos directamente desde GitHub...${NC}"
    curl -fsSL "$REPO_RAW_URL/.zshrc" -o "$HOME/.zshrc"
    curl -fsSL "$REPO_RAW_URL/starship.toml" -o "$HOME/.config/starship.toml"
    curl -fsSL "$REPO_RAW_URL/kitty/kitty.conf" -o "$HOME/.config/kitty/kitty.conf"
fi

# Asegurar que exista current-theme.conf para evitar errores si no se ha elegido tema con kitten
touch "$HOME/.config/kitty/current-theme.conf"

# ==========================================
# 5. Configurar Zsh como Shell por Defecto
# ==========================================
CURRENT_SHELL="$(basename "$SHELL")"
if [ "$CURRENT_SHELL" != "zsh" ]; then
    echo -e "${YELLOW}-> Estableciendo Zsh como tu shell por defecto...${NC}"
    ZSH_PATH="$(which zsh)"
    chsh -s "$ZSH_PATH" "$USER" || sudo chsh -s "$ZSH_PATH" "$USER" || true
fi

echo -e "\n${GREEN}====================================================${NC}"
echo -e "${GREEN} ¡Instalación y configuración completada con éxito! ${NC}"
echo -e "${GREEN}====================================================${NC}"
echo -e "Para seleccionar tu tema visual en Kitty ejecuta: ${BLUE}kitten themes${NC}"
echo -e "Para comenzar a usar tu shell ejecuta: ${GREEN}exec zsh${NC}"