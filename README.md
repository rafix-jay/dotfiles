<h1 align="center">
  🚀 .dotfiles
</h1>

<p align="center">
  A complete macOS development environment built with <a href="https://github.com/CodelyTV/dotly">🌚 Dotly</a>
</p>

<p align="center">
  <strong>Shell</strong> • <strong>Terminal</strong> • <strong>Window Manager</strong> • <strong>Status Bar</strong> • <strong>Development Tools</strong>
</p>

---

## ✨ Features

🏗️ **Complete Setup**: Zsh + Zimfw + tmux  
⚡ **Performance**: Fast shell startup with optimized configurations  
🔧 **Reproducible**: Idempotent installation avoiding generated artifacts  
🎨 **Modern**: Latest development tools and productivity utilities  
📱 **Integrated**: Seamless workspace management and system monitoring

## 🚀 Quick Start

**Prerequisites**: macOS 14.6+ • Git • Internet connection

```bash
# 1. Clone repository
git clone <your-repo-url> "$HOME/.dotfiles"
cd "$HOME/.dotfiles"

# 2. Initialize submodules
git submodule update --init --recursive modules/dotly

# 3. Run automated setup
./scripts/setup.zsh

# 4. Restart terminal
```

**What happens during setup:**
- ✅ Environment variables configured (`DOTFILES_PATH`, `DOTLY_PATH`)
- ✅ Dotly framework installed/updated
- ✅ Zimfw modules installed and shell built
- ✅ Symlinks created for configurations

## 🎯 What You Get

### 🐚 **Shell Experience**
- **Zsh + Zimfw**: Fast, modern shell with syntax highlighting and autosuggestions
- **Smart Aliases**: `gaa` (git add all), `tm` (tmux), `up` (update packages)
- **Enhanced Navigation**: Directory jumping, recent paths, fuzzy finding

### 🖥️ **Terminal & Multiplexing**
- **tmux**: Optimized for Warp terminal with intuitive key bindings
- **Session Management**: Auto-attach, named sessions, easy navigation
- **Clipboard Integration**: Seamless macOS copy/paste support

### 🪟 **Window Management**
- **App Shortcuts**: Quick application launching with keyboard shortcuts
- **Smart Layouts**: Auto-tiling with responsive gaps and orientations
- **Keyboard Navigation**: Vim-style focus controls and instant app switching

### 📊 **Status Bar**
- **Simplified Setup**: Clean terminal-focused environment
- **Media Integration**: Now playing from Apple Music with auto-scroll
- **System Metrics**: CPU, memory, network, battery, and weather

### 🛠️ **Development Tools**
- **Package Management**: Homebrew with automated Brewfile
- **VS Code Setup**: Complete extension pack for modern development
- **Git Integration**: Enhanced workflows with pretty diffs and aliases

## 📦 Quick Commands

```bash
# Package management
dot package import          # Import Dotly packages
up                         # Update all packages
brew bundle install       # Install from Brewfile

# Shell management  
zimfw install && zimfw build  # Rebuild shell after changes
zimfw update               # Update shell modules
source ~/.zshrc           # Reload shell configuration

# Symlink management
dot symlinks apply        # Apply configuration symlinks

# System management
# System monitoring removed for cleaner setup
# Window management now handled by app shortcuts
```

## 🔧 Maintenance & Customization

**Adding packages**: Install via Homebrew, then update Brewfile:

```bash
brew install <package>
brew bundle dump --file=os/mac/brew/Brewfile --force
```

**Customizing configurations**: Edit files in respective directories:

- Shell: `shell/aliases.sh`, `shell/functions.sh`
- tmux: `shell/tmux/tmux.conf`
- App Shortcuts: `os/mac/app_shortcuts.sh`  
- Terminal Tools: Focus on shell and development tools

## 📖 Documentation

For comprehensive setup guides, troubleshooting, and advanced configuration:

**📚 [→ Read the Complete Guide (GUIDE.md)](./GUIDE.md)**

Includes detailed documentation for:

- 🏗️ **Project Structure**: Directory organization and file purposes
- ⌨️ **Keyboard Shortcuts**: App shortcuts and tmux key bindings
- 🎨 **Customization**: Adding widgets, modifying themes, extending functionality
- 🛠️ **Troubleshooting**: Common issues and diagnostic commands
- 🔄 **Maintenance**: Update procedures and best practices

## ⚠️ Technical Notes

**Generated Files** (not committed):

- `shell/zsh/.zim/`: Zimfw build outputs (init.zsh, modules)
- `*.zwc`: Compiled Zsh files
- `*.old`: Backup files
- `.DS_Store`: macOS metadata

**Architecture**: Designed for idempotent installation with proper separation of generated vs. source files.
