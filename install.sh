#!/bin/bash

install_check_apt()
{
    if ! command -v "$1" &> /dev/null; then
        echo "$1 is not installed. Installing..."
        sudo apt install -y "$1"
    else
        echo "✅ $1 is already installed."
    fi
}




# Check if zsh is installed
install_check_apt zsh

sleep 1

# Check if oh-my-zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "oh-my-zsh is not installed. Installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "✅ oh-my-zsh is already installed."
fi

# Check if powerlevel10k is installed
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "powerlevel10k is not installed. Installing..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
else
    echo "✅ powerlevel10k is already installed."
fi

# Check if antigen is installed
if antigen &> /dev/null; then
    echo "antigen is not installed. Installing..."
    curl -L git.io/antigen > ~/antigen.zsh
else
    echo "✅ antigen is already installed."
fi

# Check if navi is installed
if ! command -v navi &> /dev/null; then
    echo "navi is not installed. Installing..."
    bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)
else
    echo "✅ navi is already installed."
fi

# Check if fzf is installed
install_check_apt fzf


# Check if bat is installed
install_check_apt bat



#TODO copy with original timestamp

# Update zsh config
echo "⌛ Loading shell config .zshrc"

#check if ~/.zshrc is more recent than zshrc.bak
if [ zshrc.bak -nt ~/.zshrc ]; then
    echo "  ❌Backing up current .zshrc"
    cp zshrc.bak ~/.zshrc 
else 
    echo "  ✅ Current .zshrc is already updated"
fi

# Update theme config
echo "⌛ Loading theme .p10k.zsh" 
if [ p10k.zsh.bak -nt ~/.p10k.zsh ]; then
    echo "  ❌Backing up current .p10k.zsh"
    cp p10k.zsh.bak ~/.p10k.zsh
else 
    echo "  ✅ Current .p10k.zsh is already updated"
fi

# Reload zsh config
zsh


echo "To browse the Cheatshet repositories of navi, run the command:"
echo
echo "navi repo browse"


zsh