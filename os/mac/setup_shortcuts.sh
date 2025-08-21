#!/bin/bash

# Setup Script for App Shortcuts
# Replaces AeroSpace app launching functionality

set -e

echo "🔧 Setting up app shortcuts to replace AeroSpace..."

DOTFILES_DIR="$HOME/.dotfiles"
SCRIPT_DIR="$DOTFILES_DIR/os/mac"

# Function to create macOS keyboard shortcuts
create_macos_shortcut() {
    local shortcut_name="$1"
    local app_name="$2"
    local key_combo="$3"
    
    echo "Creating shortcut: $shortcut_name -> $app_name"
    
    # Create Automator service (this requires manual setup in System Settings)
    echo "📝 Manual step required: Add '$key_combo' -> '$app_name' in System Settings → Keyboard → Shortcuts"
}

echo
echo "🚀 App Shortcuts Setup Complete!"
echo
echo "📱 Available launch commands:"
echo "   $SCRIPT_DIR/app_shortcuts.sh terminal    # Warp Terminal"
echo "   $SCRIPT_DIR/app_shortcuts.sh browser     # Brave Browser" 
echo "   $SCRIPT_DIR/app_shortcuts.sh code        # Visual Studio Code"
echo "   $SCRIPT_DIR/app_shortcuts.sh finder      # Finder"
echo "   $SCRIPT_DIR/app_shortcuts.sh intellij    # IntelliJ IDEA"
echo "   $SCRIPT_DIR/app_shortcuts.sh claude      # Claude AI"
echo "   $SCRIPT_DIR/app_shortcuts.sh perplexity  # Perplexity AI"
echo "   $SCRIPT_DIR/app_shortcuts.sh whatsapp    # WhatsApp"
echo "   $SCRIPT_DIR/app_shortcuts.sh messages    # Messages"
echo "   $SCRIPT_DIR/app_shortcuts.sh discord     # Discord"
echo "   $SCRIPT_DIR/app_shortcuts.sh telegram    # Telegram"

echo
echo "⚙️  To set up keyboard shortcuts, choose ONE of these options:"
echo
echo "🟢 Option 1: Karabiner-Elements (Recommended)"
echo "   1. Install manually: Download from https://karabiner-elements.pqrs.org/"
echo "   2. Open Karabiner-Elements"
echo "   3. Import the configuration file that will be created"
echo
echo "🟡 Option 2: macOS Shortcuts App (Built-in)"
echo "   1. Open Shortcuts app"
echo "   2. Create new shortcuts for each app"
echo "   3. Assign keyboard shortcuts in System Settings"
echo
echo "🔵 Option 3: Use the shell script directly"
echo "   Create aliases in your shell config (.zshrc, .bashrc, etc.):"
echo "   alias launch-terminal='$SCRIPT_DIR/app_shortcuts.sh terminal'"
echo "   alias launch-browser='$SCRIPT_DIR/app_shortcuts.sh browser'"
echo "   # ... etc for other apps"

echo
echo "✅ Next steps:"
echo "   1. Choose your preferred option above"
echo "   2. Test the shortcuts work correctly"
echo "   3. Mission Control is already restored and working"

# Test if apps exist
echo
echo "🔍 Checking installed applications..."
APPS_TO_CHECK=(
    "Warp"
    "Brave Browser"  
    "Visual Studio Code"
    "IntelliJ IDEA"
    "Claude"
    "Perplexity"
    "WhatsApp"
    "Discord"
    "Telegram"
)

for app in "${APPS_TO_CHECK[@]}"; do
    if [[ -d "/Applications/${app}.app" ]]; then
        echo "   ✅ $app found"
    else
        echo "   ❌ $app not found"
    fi
done