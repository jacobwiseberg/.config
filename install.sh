#!/bin/bash

# --- Setup Variables ---
TERMINAL_CONFIG_DIR="$HOME/.config"
ZSH_CUSTOM_PLUGINS="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

echo "Starting terminal configuration installation..."

# 1. Clone/Update Terminal Config Repository
if [ ! -d "$TERMINAL_CONFIG_DIR/.git" ]; then
    echo "Cloning terminal configuration to $TERMINAL_CONFIG_DIR..."
    git clone -q https://github.com/jacobwiseberg/.config.git "$TERMINAL_CONFIG_DIR" &> /dev/null
else
    echo "Configuration directory already exists. Pulling latest changes..."
    cd "$TERMINAL_CONFIG_DIR" && git pull -q &> /dev/null
fi

# 2. Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Cloning Oh My Zsh..."
    git clone -q https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh" &> /dev/null
fi

# 3. Install Zsh Plugins
echo "Installing Zsh plugins..."
mkdir -p "$ZSH_CUSTOM_PLUGINS"

# Autosuggestions
if [ ! -d "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions" ]; then
    git clone -q https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions" &> /dev/null
fi

# Syntax Highlighting
if [ ! -d "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting" ]; then
    git clone -q https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting" &> /dev/null
fi

# 4. Install Tmux Plugin Manager (TPM)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing Tmux Plugin Manager..."
    git clone -q https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" &> /dev/null
fi

# 5. Create Symlinks
echo "Creating symlinks..."
ln -sf "$TERMINAL_CONFIG_DIR/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$TERMINAL_CONFIG_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

# Ensure Neovim config directory exists
mkdir -p "$HOME/.config/nvim"

# 6. Pathing Fix (Crucial for Linux/Docker)
# This finds the hardcoded root path and replaces it with the dynamic $HOME variable
if grep -q "export ZSH=\"/.oh-my-zsh\"" "$HOME/.zshrc"; then
    echo "Fixing Zsh pathing in .zshrc..."
    # Using | as a delimiter for sed to avoid clashing with the forward slashes in paths
    sed -i 's|export ZSH="/.oh-my-zsh"|export ZSH="$HOME/.oh-my-zsh"|g' "$HOME/.zshrc"
fi

echo "-------------------------------------------------------"
echo "Installation complete."
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Open 'nvim' (Lazy.nvim will auto-install plugins)."
echo "3. Open 'tmux' and press 'prefix + I' to fetch plugins."
echo "-------------------------------------------------------"
