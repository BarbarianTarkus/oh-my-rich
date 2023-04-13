#!/bin/bash

install_check_apt()
{
    if ! command -v "$1" &> /dev/null; then
        echo "$1 is not installed. Installing..."
        sudo apt install -y "$1"
    else
        echo "$1 is already installed."
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
    echo "oh-my-zsh is already installed."
fi

# Check if powerlevel10k is installed
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "powerlevel10k is not installed. Installing..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
else
    echo "powerlevel10k is already installed."
fi

# Check if antigen is installed
if antigen &> /dev/null; then
    echo "antigen is not installed. Installing..."
    curl -L git.io/antigen > ~/antigen.zsh
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
install_check_apt fzf


# Check if bat is installed
install_check_apt bat


# Restore zsh config
echo "Loading shell config .zshrc"
cp zshrc.bak ~/.zshrc

# Restore theme config
echo "Loading theme .p10k.zsh" 
cp p10k.zsh.bak ~/.p10k.zsh

# Reload zsh config
zsh


echo "To browse the Cheatshet repositories of navi, run the command:"
echo
echo "navi repo browse"


zsh