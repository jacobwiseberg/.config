# tmux

A clean, modern Tmux setup featuring the **Catppuccin (Mocha)** theme, automated plugin management via **TPM**, and system clipboard integration.

## 🚀 Installation

### 1. Clone the repository
Clone this repo to your XDG config directory:
```bash
git clone --recursive https://github.com/jacobwiseberg/tmux ~/.config/tmux

```

*Note: The `--recursive` flag ensures the TPM submodule is downloaded automatically.*

### 2. Install System Dependencies

Ensure you have a clipboard manager installed for `tmux-yank` to work:

* **Linux (X11):** `xclip` or `xsel`
* **Linux (Wayland):** `wl-clipboard`
* **macOS:** Native support.
* **WSL:** Native support via `clip.exe`.

### 3. Initialize Plugins

1. Start a new tmux session: `tmux`
2. Press `Prefix` + `I` (Capital **I**) to fetch and install the plugins listed in `tmux.conf`.

## ⌨️ Keybindings

| Shortcut | Action |
| --- | --- |
| `Prefix` + `I` | Install new plugins |
| `Prefix` + `U` | Update plugins |
| `Prefix` + `[` | Enter Copy Mode |
| `y` (in copy mode) | Yank selection to system clipboard |
| `Mouse Drag` | Select and auto-copy to clipboard |

## 🛠️ Configuration Details

This setup uses the **XDG standard** (`~/.config/tmux/`).

### Submodule Maintenance

If plugins aren't loading or the `plugins/tpm` folder appears empty, run:

```bash
git submodule update --init --recursive

```