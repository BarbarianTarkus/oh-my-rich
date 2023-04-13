##!/bin/bash

# Check if zsh is installed
if ! command -v zsh &> /dev/null; then
    echo "zsh is not installed. Installing..."
    sudo apt install -y zsh
else
    echo "zsh is already installed."
fi

# Check if oh-my-zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "oh-my-zsh is not installed. Installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "oh-my-zsh is already installed."
fi

# Check if powerlevel10k is installed
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "powerlevel10k is not installed. Installing..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
    echo "powerlevel10k is already installed."
fi

# Check if antigen is installed
if ! command -v antigen &> /dev/null; then
    echo "antigen is not installed. Installing..."
    curl -L git.io/antigen > ~/.antigen.zsh
else
    echo "antigen is already installed."
fi

# Check if navi is installed
if ! command -v navi &> /dev/null; then
    echo "navi is not installed. Installing..."
    bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)
else
    echo "navi is already installed."
fi

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    echo "fzf is not installed. Installing..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
else
    echo "fzf is already installed."
fi

# Restore zsh config
echo "Loading shell config .zshrc"
cp ~/.zshrc ~/.zshrc.bak
cp zshrc ~/.zshrc

# Restore theme config
echo "Loading theme .p10k.zsh" 
cp ~/.p10k.zsh ~/.p10k.zsh.bak
cp p10k.zsh ~/.p10k.zsh

# Load antigen
source ~/.antigen.zsh

# Use oh-my-zsh
antigen use oh-my-zsh

# Load plugins
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen apply
EOF

# Reload zsh config
source ~/.zshrc

sudo apt -y install bat

echo "To browse the Cheatshet repositories of navi, run the command:"
echo
echo "navi repo browse"
