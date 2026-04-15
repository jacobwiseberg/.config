#!/bin/bash

# Exit on error
set -e

# 1. Variables
REPO_URL="https://github.com/jacobwiseberg/.config"
DOTFILES_DIR="$HOME/.config"

# 2. Clone or Update the Repository
if [ ! -d "$DOTFILES_DIR/.git" ]; then
    echo "Cloning config repository into $DOTFILES_DIR..."
    
    # Handle case where .config exists but is not a git repo
    if [ -d "$DOTFILES_DIR" ]; then
        echo "Merging with existing .config directory..."
        TEMP_DIR=$(mktemp -d)
        git clone "$REPO_URL" "$TEMP_DIR"
        cp -rn "$TEMP_DIR/." "$DOTFILES_DIR/"
        rm -rf "$TEMP_DIR"
        cd "$DOTFILES_DIR"
        git init
        git remote add origin "$REPO_URL"
        git fetch
        git checkout -t origin/main -f
    else
        git clone "$REPO_URL" "$DOTFILES_DIR"
    fi
else
    echo "Updating existing dotfiles repository..."
    cd "$DOTFILES_DIR"
    git pull origin main
fi

# 3. Define Sub-Paths
ZSH_DIR="$DOTFILES_DIR/zsh"
TMUX_DIR="$DOTFILES_DIR/tmux"

# 4. Setup Oh My Zsh
if [ ! -d "$ZSH_DIR/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    export ZSH="$ZSH_DIR/.oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed."
fi

# 5. Install Zsh Plugins
ZSH_CUSTOM_PLUGINS="$ZSH_DIR/custom/plugins"
mkdir -p "$ZSH_CUSTOM_PLUGINS"
plugins=("zsh-users/zsh-autosuggestions" "zsh-users/zsh-syntax-highlighting")

for repo in "${plugins[@]}"; do
    plugin_name=$(basename "$repo")
    if [ ! -d "$ZSH_CUSTOM_PLUGINS/$plugin_name" ]; then
        echo "Cloning $plugin_name..."
        git clone --depth=1 "https://github.com/$repo" "$ZSH_CUSTOM_PLUGINS/$plugin_name"
    fi
done

# 6. Setup Tmux Plugin Manager (TPM)
if [ ! -d "$TMUX_DIR/plugins/tpm" ]; then
    echo "Installing TPM..."
    mkdir -p "$TMUX_DIR/plugins"
    git clone https://github.com/tmux-plugins/tpm "$TMUX_DIR/plugins/tpm"
fi

# 7. Neovim Preparation
mkdir -p "$HOME/.local/share/nvim" "$HOME/.local/state/nvim"

# 8. Symlinks
echo "Creating symlinks..."
# Force create symbolic links to home directory
ln -sf "$ZSH_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$TMUX_DIR/tmux.conf" "$HOME/.tmux.conf"

echo "Installation complete."
echo "-------------------------------------------------------"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Open 'nvim' and wait for Lazy.nvim to sync plugins."
echo "3. Open 'tmux' and press 'prefix + I' to fetch plugins."
echo "-------------------------------------------------------"
