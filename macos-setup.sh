#!/bin/bash

# Run with:
#sh macos-setup.sh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

cd
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /Users/jonathan.domian/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/jonathan.domian/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"


# Install git
brew install git

# Install NodeJS, NPM and NVM
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash

sudo apt-get install nodejs -y

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

sudo npm install -g npm@latest -y
sudo npm install --global gulp-cli -y

# Install homebrew certificate installer for gulp
brew install mkcert
mkcert -install
mkcert "locahost"
