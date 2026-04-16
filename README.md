# .config

A minimalist, whitelist-based terminal configuration for Zsh, Tmux, and Neovim. Designed for a "cold-start" setup—moving from a blank slate to a fully productive environment in under 60 seconds.

## The Philosophy

Unlike traditional "kitchen sink" dotfile repos, this configuration uses a **whitelist strategy**. By ignoring everything by default and surgically un-ignoring only the essential configuration files, the repository remains high-signal, lightweight, and easy to maintain.

## Quick Start

To bootstrap a new machine, ensure `curl` and `git` are installed, then run:

```bash
curl -fsSL https://shift1w.com/assets/new-terminal.sh | bash
```

## Dependencies

### The Essentials (Pre-requisites)
Before running the installer, the following must be available in your `$PATH`:
* **Git**: To clone the configuration and manage plugins.
* **Curl**: To fetch the installation script.
* **Zsh**: The primary shell.
* **Tmux**: Terminal multiplexer for persistent sessions.
* **Neovim (v0.9+ recommended)**: The core text editor.

### Workflow Power-Tools
While the shell will function without these, the configuration includes aliases and integrations for a superior terminal workflow:
* **FZF**: Fuzzy finder (Auto-installed by the `install.sh` script).
* **Lazygit**: A simple terminal UI for git commands. 
* **Lazydocker**: A simple terminal UI for both docker and docker-compose.

## What’s Inside?

### Zsh
* Powered by **Oh My Zsh**.
* Plugins: `zsh-autosuggestions`, `zsh-syntax-highlighting`, and `fzf`.
* Optimized for the `lukerandall` theme.

### Neovim
* Built on a customized **kickstart.nvim** base.
* Uses **Lazy.nvim** for plugin management.
* Optimized for LSP, Treesitter, and Telescope.

### Tmux
* Managed via **TPM (Tmux Plugin Manager)**.
* Standardized keybindings for pane management and session persistence.

## Maintenance

The entire repository is cloned directly into `~/.config`. To update your configuration on any machine:

1. `cd ~/.config`
2. Make your changes to the relevant config files.
3. `git commit -am "update description"`
4. `git push origin main`

On other machines, simply run `install.sh` again or `git pull` within the `.config` directory to sync changes.

## License
The Neovim configuration is based on `kickstart.nvim`, Copyright (c) 2023 TJ DeVries. See `nvim/LICENSE.md` for details. All other scripts and configurations are free to use.
