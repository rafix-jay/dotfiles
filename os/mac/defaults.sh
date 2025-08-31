#!/usr/bin/env bash

# macOS Dock Configuration Script
# Configures dock auto-hide and show behavior

echo "Configuring macOS Dock settings..."

# Enable dock auto-hide
defaults write com.apple.dock autohide -bool true

# Set dock hide delay (shorter delay for responsiveness)
defaults write com.apple.dock autohide-delay -float 0.2

# Set dock animation speed (faster animation)
defaults write com.apple.dock autohide-time-modifier -float 0.3

# Restart Dock to apply changes
killall Dock

echo "✅ Dock auto-hide and show has been configured successfully!"
echo "The dock will now:"
echo "  • Hide automatically when not in use"
echo "  • Show when you move the cursor to the dock area"
echo "  • Use a 0.2 second delay before hiding"
echo "  • Use a 0.3 second animation speed"