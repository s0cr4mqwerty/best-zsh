# ⚡ Modern Dotfiles & Terminal Setup

Configuración automatizada y modular para un entorno de terminal de alto rendimiento, estético y productivo. Basado en **Zsh**, **Kitty Terminal**, **Starship Prompt** y utilidades CLI modernas desarrolladas en Rust y Go.

---

## 🖥️ Compatibilidad de Distribuciones

El script `install.sh` detecta automáticamente el gestor de paquetes y aprovisiona el sistema en las siguientes plataformas:

* **Arch Linux** / distribuciones derivadas (vía `pacman`)
* **Fedora** / distribuciones basadas en RHEL (vía `dnf`)
* **Debian / Ubuntu** (vía `apt` con repositorio de firmas para binarios actualizados)
* **macOS** (vía `Homebrew`)

---

## 📦 Componentes Incluidos

| Herramienta / Plugin | Propósito | Reemplaza a |
| :--- | :--- | :--- |
| **Zsh** | Shell interactiva avanzada y altamente configurable | Bash |
| **Zinit** | Gestor de plugins asíncrono y ultraveloz (Turbo Mode) | Oh-My-Zsh / Antigen |
| **Starship** | Prompt agnóstico de shell escrito en Rust | Powerlevel10k / Pure |
| **Kitty** | Emulador de terminal acelerado por GPU | Terminal estándar |
| **CaskaydiaCove Nerd Font** | Tipografía con glifos de Git, lenguajes e iconos | Fuentes estándar del sistema |
| **fzf** | Motor de búsqueda difusa (*fuzzy finder*) para archivos y comandos | Búsqueda manual / `grep` |
| **zoxide** | Navegación inteligente de directorios basada en frecuencia | `cd` |
| **eza** | Listado de archivos con iconos, colores y árbol integrado | `ls` |
| **bat** | Visualizador de archivos con resaltado de sintaxis e integración Git | `cat` |
| **zsh-autosuggestions** | Sugerencias predictivas estilo Fish en tiempo real | - |
| **fast-syntax-highlighting** | Resaltado sintáctico asíncrono de comandos en consola | zsh-syntax-highlighting |
| **fzf-tab** | Menú emergente interactivo para autocompletado con tabulador | Menú estándar de Zsh |
| **zsh-history-substring-search** | Búsqueda en historial filtrando por coincidencia parcial | Búsqueda básica de Zsh |

---

## 🚀 Instalación en un Solo Comando

Ejecuta la siguiente línea en tu terminal actual:

```bash
bash -c "$(curl -fsSL [https://raw.githubusercontent.com/s0cr4mqwerty/best-zsh/main/install.sh](https://raw.githubusercontent.com/s0cr4mqwerty/best-zsh/main/install.sh))"
```

> **Instalación manual / clonado local:**
> ```bash
> git clone [https://github.com/s0cr4mqwerty/best-zsh.git](https://github.com/s0cr4mqwerty/best-zsh.git) ~/best-zsh
> cd ~/best-zsh
> chmod +x install.sh
> ./install.sh
> ```

---

## 🎨 Personalización de Temas en Kitty

El archivo `current-theme.conf` **no se incluye en el repositorio** porque se autogenera mediante la herramienta interactiva oficial de Kitty. 

Para previsualizar y aplicar tu tema preferido (por ejemplo, **Tokyo Night Moon** o **Catppuccin Mocha**), ejecuta:

```bash
kitten themes
```

1. Navega por la lista de temas usando las flechas de tu teclado para ver una vista previa en tiempo real.
2. Presiona `Enter` sobre el tema elegido.
3. Elige la opción de modificar automáticamente tu configuración; esto generará el archivo `~/.config/kitty/current-theme.conf` sin tocar tus atajos ni opciones de ventanas.

---

## ⌨️ Atajos y Comandos Clave (Cheat Sheet)

### Shell & Navegación (Zsh + CLI)
* `Ctrl + E`: Acepta la sugerencia predictiva en gris mostrada por `zsh-autosuggestions`.
* `Ctrl + F`: Salta una palabra hacia adelante dentro de la sugerencia.
* `Flecha Arriba / Flecha Abajo`: Con texto ya escrito (ej. `git`), busca únicamente comandos pasados en el historial que contengan esa palabra.
* `Tab`: Abre el menú interactivo flotante gestionado por `fzf-tab` para autocompletar rutas o argumentos.
* `Ctrl + R`: Abre la búsqueda difusa del historial interactivo con `fzf`.
* `z <carpeta>`: Salta a directorios frecuentados sin escribir la ruta absoluta ni relativa (ej. `z descargas`).
* `ls`: Lista archivos con iconos y directorios agrupados al inicio (`eza`).
* `ll`: Lista detallada con permisos octales y fechas legibles (`eza -la`).
* `tree`: Despliega la jerarquía de carpetas en un árbol gráfico.
* `cat <archivo>`: Visualiza archivos con números de línea y soporte de colores (`bat`).

### Terminal Kitty
* `Ctrl + Shift + Enter`: Abre una nueva ventana dividida dentro de la pestaña actual.
* `Ctrl + Shift + T`: Abre una nueva pestaña.
* `Ctrl + Shift + Q`: Cierra la ventana activa.
* `Ctrl + Shift + ]` / `[`: Navega hacia la ventana siguiente o anterior.
* `Ctrl + Shift + Right` / `Left`: Cambia de pestaña hacia la derecha o izquierda.
* `Ctrl + Shift + +` / `-`: Ajusta dinámicamente el tamaño de la tipografía.