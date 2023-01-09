#!/bin/bash

# Run with:
#sh macos-setup.sh

# Show hidden files and folders
defaults write com.apple.Finder AppleShowAllFiles true
killall Finder

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Kayids Theme for Integrity computer
# https://github.com/AmrMKayid/KayidmacOS/blob/master/kayid.zsh-theme
# Add to /Users/jonathan.domian/.oh-my-zsh/themes/kayid.zsh-theme
# Change ~/.zshrc ZSH_THEME="kayid"

# Install and configure homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /Users/jonathan.domian/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/jonathan.domian/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
echo "# Homebrew\nexport PATH=/opt/homebrew/bin:\$PATH" >> .zshrc
source ~/.zshrc

# Update homebrew
brew update

# Install git
brew install git

# Install NodeJS, NPM and NVM
brew install node=
brew install nvm
mkdir ~/.nvm
echo "export NVM_DIR=~/.nvm\nsource \$(brew --prefix nvm)/nvm.sh" >> .zshrc
source ~/.zshrc

nvm install node
nvm ls-remote

# Install homebrew certificate installer for gulpJS
brew install mkcert
mkcert -install
mkcert "locahost"

# Install all gulpJS and firebase-tools dependencies
npm install -g browser-sync del gulp gulp-babel gulp-clean-css gulp-cli gulp-concat gulp-csso gulp-install gulp-less gulp-load-plugins gulp-minify gulp-rename gulp-sass gulp-sourcemaps gulp-uglify sass express firebase-tools
