#!/bin/bash




install_apt()
{
    if ! command -v "$1" &> /dev/null; then
        echo "$1 is not installed. Installing..."
        sudo apt install -y "$1"
    else
        echo "✅ $1 is already installed."
    fi
}





install_oh_my_zsh() {
    # Check if oh-my-zsh is installed
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "oh-my-zsh is not installed. Installing..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        echo "✅ oh-my-zsh is already installed."
    fi
}

install_powerlevel10k(){
    # Check if powerlevel10k is installed
    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
        echo "powerlevel10k is not installed. Installing..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
    else
        echo "✅ powerlevel10k is already installed."
    fi
}


install_antigen (){
    # Check if antigen is installed
    if antigen &> /dev/null; then
        echo "antigen is not installed. Installing..."
        curl -L git.io/antigen > ~/antigen.zsh
    else
        echo "✅ antigen is already installed."
    fi
}

install_navi() {
    # Check if navi is installed
    if ! command -v navi &> /dev/null; then
        echo "navi is not installed. Installing..."
        bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)
    else
        echo "✅ navi is already installed."
    fi
}

copy_config_files(){

    config_location=configuration
    zshrc_file=$config_location/zshrc.bak
    p10k_file=$config_location/p10k.zsh.bak

    #TODO copy with original timestamp

    # Update zsh config
    echo "⌛ Loading shell config .zshrc"

    #check if ~/.zshrc is more recent than zshrc.bak
    if [ $zshrc_file -nt ~/.zshrc ]; then
        echo "  ❌Backing up current .zshrc"
        cp -p $zshrc_file ~/.zshrc 
    else 
        echo "  ✅ Current .zshrc is already updated"
    fi

    # Update theme config
    echo "⌛ Loading theme .p10k.zsh" 
    if [ p10k_file -nt ~/.p10k.zsh ]; then
        echo "  ❌Backing up current .p10k.zsh"
        cp -p $p10k_file ~/.p10k.zsh
    else 
        echo "  ✅ Current .p10k.zsh is already updated"
    fi
}

## Main

install_apt zsh

install_oh_my_zsh

install_powerlevel10k

install_antigen

install_navi

install_apt fzf

install_apt bat

copy_config_files

# reload zsh
zsh