# Dotfiles Project Guide

A comprehensive guide to managing and using this dotfiles configuration built with [Dotly](https://github.com/CodelyTV/dotly).

## 📋 Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Quick Start](#quick-start)
- [Package Management](#package-management)
- [Configuration Files](#configuration-files)
- [Shell Configuration](#shell-configuration)
- [Terminal Tools](#terminal-tools)
- [Development Environment](#development-environment)
- [Maintenance](#maintenance)
- [Troubleshooting](#troubleshooting)

## 🎯 Overview

This dotfiles repository provides a complete development environment setup for macOS, featuring:

- **Shell Environment**: Zsh with Zimfw framework
- **Package Management**: Homebrew with automated installation
- **Terminal Multiplexer**: tmux with Warp integration
- **Window Management**: Aerospace tiling window manager
- **Status Bar**: SketchyBar for system monitoring
- **Development Tools**: Complete VS Code setup, Git configuration, and CLI tools

### Key Features

- ✅ **Reproducible Setup**: Idempotent installation scripts
- ✅ **Cross-Device Sync**: Consistent environment across machines
- ✅ **Modular Design**: Easy to customize and extend
- ✅ **Modern Tools**: Latest development tools and utilities
- ✅ **Performance Optimized**: Fast shell startup and efficient workflows

## 📁 Project Structure

```
.dotfiles/
├── README.md                 # Basic setup instructions
├── GUIDE.md                  # This comprehensive guide
├── .gitignore               # Ignore generated files
├── scripts/
│   └── setup.zsh           # Main setup script
├── shell/
│   ├── aliases.sh           # Command aliases
│   ├── exports.sh           # Environment variables
│   ├── functions.sh         # Custom shell functions
│   ├── init.sh             # Shell initialization
│   ├── tmux/
│   │   └── tmux.conf       # tmux configuration
│   └── zsh/
│       ├── .zimrc          # Zimfw module configuration
│       ├── .zshenv         # Zsh environment
│       ├── .zshrc          # Zsh configuration
│       └── .zim/           # Generated Zimfw files (gitignored)
├── os/mac/
│   ├── brew/
│   │   └── Brewfile        # Homebrew packages
│   ├── aerospace.toml      # Window manager config
│   ├── sketchybar/         # Status bar configuration
│   └── .dotly              # Dotly macOS settings
├── symlinks/
│   ├── conf.yaml           # Cross-platform symlinks
│   ├── conf.macos.yaml     # macOS-specific symlinks
│   └── conf.linux.yaml    # Linux symlinks
├── restoration_scripts/
│   └── 01-sample_script.sh # Post-install automation
└── modules/
    └── dotly/              # Dotly framework (submodule)
```

## 🚀 Quick Start

### Prerequisites

- macOS (tested on macOS 14.6+)
- Git installed
- Internet connection

### Installation

1. **Clone the repository**:
   ```bash
   git clone <your-repo-url> "$HOME/.dotfiles"
   cd "$HOME/.dotfiles"
   ```

2. **Initialize submodules**:
   ```bash
   git submodule update --init --recursive modules/dotly
   ```

3. **Run setup script**:
   ```bash
   ./scripts/setup.zsh
   ```

4. **Restart your terminal**

### What the Setup Does

- Sets environment variables (`DOTFILES_PATH`, `DOTLY_PATH`)
- Installs/updates Dotly framework
- Installs Zimfw and shell modules
- Creates necessary symlinks
- Builds shell configuration files

## 📦 Package Management

### Homebrew Packages

The `os/mac/brew/Brewfile` contains all managed packages:

#### Core Development Tools
- **Languages**: `python@3.13`, `go`, `deno`, `node` (via nvm)
- **Package Managers**: `pnpm`, `pyenv`, `uv`
- **Version Control**: `gh` (GitHub CLI)
- **Build Tools**: `make`, `pkgconf`

#### CLI Utilities
- **File Management**: `tree`, `bat`, `fzf`, `ripgrep`
- **System Tools**: `coreutils`, `findutils`, `gnu-sed`
- **Text Processing**: `jq`, `midnight-commander`
- **Security**: `gnupg`, `pinentry-mac`

#### Terminal and Shell
- **Terminal**: `tmux`, `zsh`
- **Editor**: `neovim`
- **Monitoring**: `hyperfine`

#### Applications (Casks)
- **Development**: OrbStack, 1Password CLI
- **Fonts**: Nerd Fonts, SF Pro
- **Productivity**: Aerospace, SketchyBar
- **Terminal**: WezTerm

#### VS Code Extensions
- Comprehensive development extensions for:
  - Python, Go, TypeScript/JavaScript
  - Docker, Kubernetes, Terraform
  - AWS, GitHub integration
  - Code quality and formatting tools

### Package Management Commands

```bash
# Install all packages
dot package import

# Update all packages
dot package update_all

# Add new package
brew install <package-name>
# Then update Brewfile
brew bundle dump --file=os/mac/brew/Brewfile --force
```

## ⚙️ Configuration Files

### Symlink Management

Symlinks are managed through YAML files in the `symlinks/` directory:

- **`conf.yaml`**: Cross-platform symlinks
- **`conf.macos.yaml`**: macOS-specific symlinks
- **`conf.linux.yaml`**: Linux-specific symlinks

#### Apply Symlinks
```bash
dot symlinks apply
```

### Key Configurations

| Source | Target | Purpose |
|--------|--------|---------|
| `shell/tmux/tmux.conf` | `~/.tmux.conf` | tmux configuration |
| `os/mac/aerospace.toml` | `~/.aerospace.toml` | Window manager |
| `os/mac/sketchybar/` | `~/.config/sketchybar/` | Status bar |
| `shell/zsh/.zshrc` | `~/.zshrc` | Zsh configuration |

## 🐚 Shell Configuration

### Zsh with Zimfw

The shell uses **Zimfw** as the framework with these modules:

- **Core**: `environment`, `git`, `input`, `termtitle`, `utility`
- **Productivity**: `completion`, `syntax-highlighting`, `autosuggestions`
- **Prompt**: Custom prompt configuration
- **History**: Enhanced history management

### Aliases

#### Git Shortcuts
```bash
gaa     # git add -A
gc      # git commit (with Dotly)
gco     # git checkout
gd      # git diff (pretty)
gs      # git status
gps     # git push
gpl     # git pull --rebase
```

#### tmux Shortcuts
```bash
tm      # tmux
tma     # tmux attach-session
tmn     # tmux new-session
tml     # tmux list-sessions
tmns    # tmux_new_session (in current dir)
tmon    # tmux_attach_or_new
```

#### Utilities
```bash
..      # cd ..
...     # cd ../..
ll      # ls -l
la      # ls -la
k       # kill -9
up      # update all packages
```

### Functions

#### Navigation
- `cdd()`: Change to directory with fzf selection
- `j()`: Jump to frequent directories (z integration)
- `recent_dirs()`: Navigate to recent directories with fzf

#### tmux Integration
- `tmux_new_session()`: Create session in current directory
- `tmux_attach_or_new()`: Attach to existing or create new session
- `tmux_kill_all()`: Kill all tmux sessions
- `tmux_session_list()`: List sessions with details

## 🖥️ Terminal Tools

### tmux Configuration

Optimized for **Warp terminal** integration:

#### Key Bindings
- **Prefix**: `Ctrl-a` (easier than `Ctrl-b`)
- **Split Panes**: `|` (horizontal), `-` (vertical)
- **Navigate**: `Alt + arrow keys` (no prefix)
- **Resize**: `Shift + arrow keys`
- **Reload Config**: `Ctrl-a + r`

#### Features
- ✅ True color support for Warp
- ✅ Mouse support enabled
- ✅ macOS clipboard integration
- ✅ Custom status bar
- ✅ Vi-mode copy selection

### Aerospace Window Manager

**AeroSpace** is a tiling window manager for macOS that automatically arranges windows in non-overlapping tiles. Configuration in `os/mac/aerospace.toml`.

#### Workspace Organization

**Semantic Workspaces** - Each workspace has a specific purpose:

| Workspace | Purpose | Auto-assigned Apps |
|-----------|---------|-------------------|
| **T** | Terminal | Warp |
| **B** | Browser | Brave, Safari, Chrome, Firefox |
| **C** | Code | VS Code |
| **I** | IntelliJ | IntelliJ IDEA |
| **A** | AI Tools | Claude, Perplexity (app) |
| **M** | Messaging | WhatsApp, Messages, Discord, Telegram |
| **F** | Files | Finder |
| **N** | Notes | Notes, TextEdit |
| **P** | Photo/Preview | Photoshop, Lightroom Classic, Hasselblad Phocus, Preview |
| **V** | Video | Final Cut, Premiere Pro |
| **U** | mUsic | Music, Spotify |
| **D** | Documentation | Documentation apps |
| **1-9** | General | General purpose workspaces |

#### Key Bindings Reference

**🚀 Application Shortcuts** (Quick Launch)
```
Cmd+Alt+T    → Open Warp (Terminal)
Cmd+Alt+B    → Open Brave Browser
Cmd+Alt+C    → Open Visual Studio Code
Cmd+Alt+F    → Open Finder
Cmd+Alt+I    → Open IntelliJ IDEA
Cmd+Alt+A    → Open Claude (AI Assistant)
Cmd+Alt+P    → Open Perplexity (AI Search)
Cmd+Alt+W    → Open WhatsApp
Cmd+Alt+M    → Open Messages
Cmd+Alt+D    → Open Discord
Cmd+Alt+G    → Open ChatGPT (web)
Cmd+Shift+Alt+T → Open Telegram
Cmd+Shift+Alt+L → Open Adobe Lightroom Classic
Cmd+Shift+Alt+S → Open Adobe Photoshop
```

**🎯 Focus Navigation** (Vim-style)
```
Alt+H        → Focus left window
Alt+J        → Focus down window
Alt+K        → Focus up window
Alt+L        → Focus right window

Cmd+Alt+H    → Focus left monitor
Cmd+Alt+J    → Focus down monitor
Cmd+Alt+K    → Focus up monitor
Cmd+Alt+L    → Focus right monitor
```

**📱 Window Movement**
```
Alt+Shift+H  → Move window left
Alt+Shift+J  → Move window down
Alt+Shift+K  → Move window up
Alt+Shift+L  → Move window right
```

**📐 Window Resizing**
```
Alt+-        → Resize window smaller (-50px)
Alt+=        → Resize window larger (+50px)

Cmd+Ctrl+Alt+Shift+R → Enter resize mode
```

**📱 Workspace Navigation**
```
Alt+1-9      → Switch to numbered workspace (1-9)
Alt+A-Z      → Switch to lettered workspace (A-Z)

Alt+Shift+1-9 → Move window to numbered workspace
Alt+Shift+A-Z → Move window to lettered workspace

Alt+Tab      → Switch to previous workspace
Alt+Shift+Tab → Move workspace to next monitor
```

**🎛️ Layout Control**
```
Alt+/        → Toggle tiles horizontal/vertical
Alt+,        → Toggle accordion horizontal/vertical
Alt+.        → Toggle tiles/accordion layout

Alt+Shift+Enter → Toggle fullscreen
Alt+Shift+Space → Toggle floating/tiling
Alt+Shift+=     → Balance window sizes
Alt+Shift+\     → Reset workspace layout
```

**⚙️ Service Mode** (Alt+Shift+;)
```
Alt+Shift+;  → Enter service mode

In service mode:
Esc          → Reload config and exit
R            → Reset layout and exit
F            → Toggle floating/tiling and exit
Backspace    → Close all windows but current
C            → Center floating window
B            → Balance all window sizes
M            → Toggle fullscreen
1            → Set tiles layout
2            → Set accordion layout
3            → Set floating layout
W            → Close all windows but current
Q            → Reset workspace layout

Alt+Shift+H/J/K/L → Join with adjacent window
```

**📏 Resize Mode** (Cmd+Ctrl+Alt+Shift+R)
```
H/J/K/L      → Resize by 50px
Shift+H/J/K/L → Fine resize by 10px
1            → Reset to balanced
2            → Make smaller (-200px)
3            → Make larger (+200px)
Alt+=        → Balance all windows
Esc/Enter    → Exit resize mode
```

**🔧 System Controls**
```
Cmd+Ctrl+Alt+Shift+Q → Reload AeroSpace config
Cmd+Ctrl+Alt+Shift+C → Center mouse in current window
Cmd+Ctrl+Alt+Shift+X → Emergency layout reset
Alt+Shift+0          → Refresh SketchyBar workspace indicators
```

#### Layout Features

- **Auto-gaps**: Responsive gaps (8px on main display, 12px on external)
- **Smart orientation**: Horizontal for wide monitors, vertical for tall
- **Accordion padding**: 30px padding for accordion layout
- **Mouse follows focus**: Automatic mouse positioning
- **SketchyBar integration**: 45px top padding for status bar

### SketchyBar

**SketchyBar** is a highly customizable status bar replacement for macOS. Configuration in `os/mac/sketchybar/`.

#### Layout Overview

```
[Workspaces] [Chevron] [Current App]     [Media Player]     [System Info] [Clock]
    Left Side                               Center                Right Side
```

#### Workspace Indicators (Left)

**Interactive Workspace Buttons**:
- **Visual States**: 
  - Active: Highlighted with accent color (cyan)
  - Inactive: Transparent background, white icon
- **Click Actions**: Click any workspace to switch instantly
- **Real-time Updates**: Automatically updates when workspace changes
- **Displayed Workspaces**: T, B, C, I, A, M, 1, 2, 3 (most commonly used)

#### Current Application Display (Left)

- **App Name**: Shows currently focused application
- **Dynamic Updates**: Changes in real-time as you switch applications
- **Chevron Separator**: Visual separator with arrow icon

#### Media Center (Center)

- **Now Playing**: Displays currently playing media from Apple Music
- **Scrolling Text**: Long titles scroll automatically
- **Auto-hide**: Hidden when no media is playing
- **Update Frequency**: Refreshes every 5 seconds

#### System Monitoring (Right)

**Real-time System Information**:

| Widget | Icon | Info | Update Freq |
|--------|------|------|-------------|
| **Clock** | 󰥔 | Date and time | 10 seconds |
| **Weather** | | Current conditions | 5 minutes |
| **Volume** | 🔊 | Audio level | Event-based |
| **Battery** | 🔋 | Charge % and status | 2 minutes |
| **CPU** | 󰘚 | Usage percentage | 2 seconds |
| **Memory** | 📊 | RAM usage | 5 seconds |
| **Network** | 🌐 | Connection status | 10 seconds |
| **Disk** | 💽 | Storage usage | 1 minute |

#### Color Scheme

```
Background:   Semi-transparent with blur
Icons:        White (#ffffff)
Labels:       White (#ffffff)
Active WS:    Cyan accent (#8bd5ca)
Highlights:   Green accent (#a6da95)
```

#### Plugin System

All widgets are powered by shell scripts in `plugins/` directory:

- **`space.sh`**: AeroSpace workspace integration
- **`update_workspaces.sh`**: Manual workspace refresh
- **`front_app.sh`**: Current application detection
- **`media.sh`**: Apple Music integration
- **`clock.sh`**: Date/time display
- **`weather.sh`**: Weather information
- **`volume.sh`**: Audio level monitoring
- **`battery.sh`**: Power status
- **`cpu.sh`**: CPU usage calculation
- **`memory.sh`**: RAM usage monitoring
- **`network.sh`**: Network status
- **`disk.sh`**: Storage monitoring

#### SketchyBar Controls

```bash
# Refresh workspace indicators
sketchybar --trigger aerospace_workspace_change

# Update all widgets
sketchybar --update

# Reload configuration
sketchybar --reload

# Check status
sketchybar --query bar
```

#### Customization

**Adding New Widgets**:
1. Create plugin script in `plugins/` directory
2. Add widget configuration to `sketchybarrc`
3. Set update frequency or event subscription
4. Reload SketchyBar

**Modifying Appearance**:
- Edit color variables in `sketchybarrc`
- Adjust fonts, sizes, and spacing
- Modify background blur and transparency

#### Integration Features

- **AeroSpace Sync**: Workspace indicators update automatically
- **Event System**: Responds to system changes instantly
- **Plugin Architecture**: Modular and extensible design
- **Performance**: Efficient updates with minimal CPU usage
- **Accessibility**: Clear visual indicators and proper contrast

## 💻 Development Environment

### VS Code Integration

Comprehensive extension pack including:

#### Language Support
- **Python**: Full toolchain (pylance, debugpy, ruff)
- **JavaScript/TypeScript**: Complete development setup
- **Go**: Official Go extension
- **Terraform**: Infrastructure as code
- **Docker**: Container development

#### Productivity
- **GitHub**: Copilot, PR management, Actions
- **AWS**: Toolkit for cloud development
- **Remote Development**: SSH, containers
- **Code Quality**: ESLint, Prettier, spell checker

### Git Configuration

Enhanced Git workflow with:
- **Pretty diff/log**: Visual git history
- **Commit helpers**: Standardized commit messages
- **Branch management**: Simplified workflows

## 🔧 Maintenance

### Regular Updates

```bash
# Update all packages
up

# Update Zimfw modules
zimfw update

# Update Dotly framework
dot self update

# Rebuild shell configuration
zimfw install && zimfw build
```

### Adding New Packages

1. **Install package**:
   ```bash
   brew install <package-name>
   ```

2. **Update Brewfile**:
   ```bash
   brew bundle dump --file=os/mac/brew/Brewfile --force
   ```

3. **Commit changes**:
   ```bash
   git add os/mac/brew/Brewfile
   git commit -m "Add <package-name> to Brewfile"
   ```

### Customization

#### Adding New Aliases
Edit `shell/aliases.sh` and reload:
```bash
source ~/.zshrc
```

#### Adding New Functions
Edit `shell/functions.sh` and reload:
```bash
source ~/.zshrc
```

#### Modifying tmux
Edit `shell/tmux/tmux.conf` and reload:
```bash
tmux source-file ~/.tmux.conf
```

## 🛠️ Troubleshooting

### Common Issues

#### Slow Shell Startup
```bash
# Profile shell startup
zsh -xvs

# Check Zimfw compilation
zimfw build
```

#### Missing Symlinks
```bash
# Reapply symlinks
dot symlinks apply
```

#### tmux Not Working
```bash
# Check tmux version
tmux -V

# Test configuration
tmux source-file ~/.tmux.conf
```

#### Brew Packages Not Installing
```bash
# Update Homebrew
brew update

# Install from Brewfile
brew bundle install --file=os/mac/brew/Brewfile
```

### Diagnostic Commands

```bash
# Check Dotly status
dot doctor

# Verify environment variables
echo $DOTFILES_PATH
echo $DOTLY_PATH

# Check shell configuration
which zsh
echo $SHELL

# List loaded Zimfw modules
zimfw list
```

### Clean Installation

If you need to start fresh:

1. **Backup current config**:
   ```bash
   mv ~/.zshrc ~/.zshrc.backup
   mv ~/.tmux.conf ~/.tmux.conf.backup
   ```

2. **Clean Zimfw**:
   ```bash
   rm -rf ~/.dotfiles/shell/zsh/.zim
   ```

3. **Re-run setup**:
   ```bash
   cd ~/.dotfiles
   ./scripts/setup.zsh
   ```

## 📚 Additional Resources

- [Dotly Documentation](https://github.com/CodelyTV/dotly)
- [Zimfw Documentation](https://github.com/zimfw/zimfw)
- [tmux Manual](https://man.openbsd.org/tmux.1)
- [Aerospace Guide](https://github.com/nikitabobko/AeroSpace)
- [SketchyBar Documentation](https://github.com/FelixKratz/SketchyBar)

---

**Last Updated**: 2025-01-17

For issues or contributions, please check the repository's issue tracker or submit a pull request.