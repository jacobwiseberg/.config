# --- Pathing & Oh My Zsh ---
export ZSH="$HOME/.oh-my-zsh"
export FZF_BASE="$HOME/.fzf"

# Set the theme
ZSH_THEME="lukerandall"

# Define the custom folder location
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# --- Plugins ---
plugins=(
  git 
  fzf 
  zsh-autosuggestions 
  zsh-syntax-highlighting
)

# Load Oh My Zsh
source "$ZSH/oh-my-zsh.sh"

# --- Personal Aliases ---
alias zshconfig="nvim $HOME/.config/zsh/.zshrc"
alias vim='nvim'
alias lzd='lazydocker'
alias lg='lazygit'

# --- Environment Variables ---
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi
