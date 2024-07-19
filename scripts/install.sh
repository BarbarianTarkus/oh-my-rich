#!/bin/bash

install_apt() {
    if ! type "$1" &>/dev/null; then
        echo "$1 is not installed. Installing..."
        if ! sudo apt install -y "$1"; then
            echo "✅ $1 installed successfully."
        else
            echo "❌ $1 installation failed. You can try to install it manually or if you are not on Debian, use your package manager."
            exit 0
        fi
    else
        echo "✅ $1 is already installed."
    fi
}

install_fzf() {
    if ! type fzf &>/dev/null; then
        echo "⌛fzf is not installed. Installing..."
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
        echo "✅ fzf installed successfully."
    else
        echo "✅ fzf is already installed."
    fi
}

install_zsh() {
    if [ -z "$ZSH_VERSION" ]; then
        echo "⌛zsh is not installed. Installing..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        echo "✅ zsh installed successfully."
    else
        echo "✅ zsh is already installed."
    fi
}

install_oh_my_zsh() {
    # Check if oh-my-zsh is installed
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "oh-my-zsh is not installed. Installing..."
        # Installing oh-my-zsh
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        echo "✅ oh-my-zsh is already installed."
    fi
}

install_powerlevel10k() {
    # Check if powerlevel10k is installed
    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
        echo "⌛powerlevel10k is not installed. Installing..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME"/powerlevel10k
    else
        echo "✅ powerlevel10k is already installed."
    fi
}

install_zinit() {
    if ! type zinit &>/dev/null; then
        echo "⌛zinit could not be found, installing now..."
        bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
        echo "✅ zinit is installed. You can now use it to install plugins."
    else
        echo "✅ zinit is already installed."
    fi
}

install_navi() {
    # Check if navi is installed
    if ! type navi &>/dev/null; then
        echo "⌛navi is not installed. Installing..."
        bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)
    else
        echo "✅ navi is already installed."
    fi
}




check_and_copy() {
    cp -a "$1" "$2" # -p: Preserve all: metadata & attributes
    echo "✅ Current $1 is already updated"
}

copy_config_files() {
    zshrc_file=./configuration/zshrc.bak
    p10k_file=./configuration/p10k.zsh.bak

    # Update zsh config
    echo "⌛ Loading shell config .zshrc"
    check_and_copy $zshrc_file "$HOME"/.zshrc

    # Update theme config
    echo "⌛ Loading theme .p10k.zsh"
    check_and_copy $p10k_file "$HOME"/.p10k.zsh
}




## Main

install_zsh

copy_config_files

install_oh_my_zsh

install_powerlevel10k

install_zinit

install_navi

install_fzf


echo "Do you want to install bat(only if you have apt)? [y/n]"
read -r response
case $response in
    [Yy]*)
        install_apt bat
        ;;
    *)
        echo "⏩Skipping bat installation."
        # Remove alias from zshrc.bak: "alias badcat="cat"         
        sed -i '/alias badcat/d' $zshrc_file
        ;;
esac


# reload zsh
zsh
