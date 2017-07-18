#!/bin/sh

# Allow text selection in the Quick Look window
# source: https://github.com/sindresorhus/quick-look-plugins
defaults write com.apple.finder QLEnableTextSelection -bool true && killall Finder

# Move the dock to the end of the screen. Note the lowercase `dock` in
# the command. That's for OS X Mavericks. `Dock` is used for earlier
# versions of OS X.
defaults write com.apple.dock pinning end && killall Dock

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Remove shadow from screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1


# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# Turn off desktop icons
defaults write com.apple.finder CreateDesktop -bool false
