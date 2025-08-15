#!/usr/bin/env zsh
set -euo pipefail

# Idempotent setup for dotfiles using Dotly + Zimfw
# - Ensures environment variables
# - Initializes Dotly submodule and runs dot self install
# - Installs and builds Zimfw generated files

# Resolve repo root based on this script location
SCRIPT_DIR=${0:A:h}
REPO_ROOT=${SCRIPT_DIR:h}

# Environment
export DOTFILES_PATH=${DOTFILES_PATH:-$REPO_ROOT}
export DOTLY_PATH=${DOTLY_PATH:-$DOTFILES_PATH/modules/dotly}
export ZDOTDIR=${ZDOTDIR:-$DOTFILES_PATH/shell/zsh}
export ZIM_HOME=${ZIM_HOME:-$ZDOTDIR/.zim}

print -P "%F{cyan}DOTFILES_PATH=%f $DOTFILES_PATH"
print -P "%F{cyan}DOTLY_PATH=%f   $DOTLY_PATH"
print -P "%F{cyan}ZDOTDIR=%f       $ZDOTDIR"
print -P "%F{cyan}ZIM_HOME=%f      $ZIM_HOME"

mkdir -p "$ZIM_HOME"

# Ensure Dotly submodule
if [ -d "$DOTLY_PATH/.git" ] || [ -f "$DOTLY_PATH/.git" ] || [ -d "$DOTLY_PATH" ]; then
  print -P "%F{green}Dotly directory present:%f $DOTLY_PATH"
else
  print -P "%F{yellow}Dotly directory missing, initializing submodule...%f"
fi

if command -v git >/dev/null 2>&1; then
  # Initialize submodule if needed (idempotent)
  git -C "$DOTFILES_PATH" submodule update --init --recursive modules/dotly || true
else
  print -P "%F{red}git is required to initialize Dotly.%f"; exit 1
fi

# Run Dotly self install (idempotent)
if [ -x "$DOTLY_PATH/bin/dot" ]; then
  print -P "%F{cyan}Running dot self install...%f"
  DOTFILES_PATH="$DOTFILES_PATH" DOTLY_PATH="$DOTLY_PATH" "$DOTLY_PATH/bin/dot" self install || true
else
  print -P "%F{yellow}Dotly binary not found at $DOTLY_PATH/bin/dot. Skipping dot self install.%f"
fi

# Locate zimfw loader
ZIMFW_LOADER=""
if [ -f "/opt/homebrew/opt/zimfw/share/zimfw.zsh" ]; then
  ZIMFW_LOADER="/opt/homebrew/opt/zimfw/share/zimfw.zsh"
elif [ -f "/usr/local/share/zimfw/zimfw.zsh" ]; then
  ZIMFW_LOADER="/usr/local/share/zimfw/zimfw.zsh"
fi

if [ -n "$ZIMFW_LOADER" ]; then
  print -P "%F{cyan}Sourcing zimfw from:%f $ZIMFW_LOADER"
  source "$ZIMFW_LOADER"
else
  if command -v zimfw >/dev/null 2>&1; then
    : # zimfw function/command available by other means
  else
    print -P "%F{yellow}zimfw not found via Homebrew. Attempting network install into current session...%f"
    # Fallback to online installer for the session only
    if command -v curl >/dev/null 2>&1; then
      source /dev/stdin <<'EOF'
      $(curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh)
EOF
    elif command -v wget >/dev/null 2>&1; then
      source /dev/stdin <<'EOF'
      $(wget -qO- https://raw.githubusercontent.com/zimfw/install/master/install.zsh)
EOF
    else
      print -P "%F{red}Neither Homebrew zimfw nor curl/wget available. Cannot proceed with zimfw.%f"
      exit 1
    fi
  fi
fi

# Ensure .zimrc exists
if [ ! -f "$ZDOTDIR/.zimrc" ]; then
  print -P "%F{yellow}No .zimrc found at $ZDOTDIR/.zimrc. Creating a minimal one...%f"
  cat > "$ZDOTDIR/.zimrc" <<'RC'
# Minimal Zimfw modules
zmodule zimfw/environment
zmodule zimfw/git
zmodule zimfw/input
zmodule zimfw/utility
zmodule zimfw/completion
zmodule zsh-users/zsh-syntax-highlighting
zmodule zsh-users/zsh-autosuggestions
RC
fi

# Install and build Zimfw (idempotent)
print -P "%F{cyan}zimfw install%f"
ZDOTDIR="$ZDOTDIR" ZIM_HOME="$ZIM_HOME" zimfw install || true
print -P "%F{cyan}zimfw build%f"
ZDOTDIR="$ZDOTDIR" ZIM_HOME="$ZIM_HOME" zimfw build || true

print -P "%F{green}Setup complete.%f Generated files in: $ZIM_HOME"

