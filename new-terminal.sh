#!/bin/bash

# --- Setup Variables ---
TERMINAL_CONFIG_DIR="$HOME/.config"
ZSH_CUSTOM_PLUGINS="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

echo "Starting terminal configuration installation..."

# 1. Clone/Update Terminal Config Repository
if [ ! -d "$TERMINAL_CONFIG_DIR/.git" ]; then
    echo "Initializing terminal configuration in $TERMINAL_CONFIG_DIR..."
    
    mkdir -p "$TERMINAL_CONFIG_DIR"
    cd "$TERMINAL_CONFIG_DIR"

    # Initialize and map to your GitHub
    git init -q
    git remote add origin https://github.com/jacobwiseberg/.config.git
    
    # Fetch and force-align with the main branch
    git fetch -q origin
    git checkout -q -f main
    
    # Set the upstream so future 'git pull' commands know where to go
    git branch --set-upstream-to=origin/main main
else
    echo "Configuration directory already exists. Preparing for sync..."
    cd "$TERMINAL_CONFIG_DIR"
fi

# 2. Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Cloning Oh My Zsh..."
    git clone -q https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh" &> /dev/null
fi

# 3. Install Zsh Plugins
echo "Installing Zsh plugins..."
mkdir -p "$ZSH_CUSTOM_PLUGINS"

if [ ! -d "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions" ]; then
    git clone -q https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions" &> /dev/null
fi

if [ ! -d "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting" ]; then
    git clone -q https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting" &> /dev/null
fi

# 4. Install fzf
if [ ! -d "$HOME/.fzf" ]; then
    echo "Installing fzf..."
    git clone -q --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf" &> /dev/null
    "$HOME/.fzf/install" --all --quiet &> /dev/null
fi

# 5. Install Tmux Plugin Manager (TPM)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing Tmux Plugin Manager..."
    git clone -q https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" &> /dev/null
fi

# 6. Create Symlinks
echo "Creating symlinks..."
ln -sf "$TERMINAL_CONFIG_DIR/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$TERMINAL_CONFIG_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

# Ensure Neovim config directory exists
mkdir -p "$HOME/.config/nvim"

# 7. Final Repository Sync
echo "Performing final sync..."
cd "$TERMINAL_CONFIG_DIR"
git pull -q origin main &> /dev/null

echo "-------------------------------------------------------"
echo "Installation complete."
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Open 'nvim' (Lazy.nvim will auto-install plugins)."
echo "3. Open 'tmux' and press 'prefix + I' to fetch plugins."
