#!/bin/bash


# Definir colores
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # Sin color



dependencies=("zsh" "curl" "git")

install_apt() {
    if ! type "$1" &>/dev/null; then
        echo "$1 is not installed. Installing..."
        if sudo apt install -y "$1"; then
            echo "✅ $1 installed successfully."
        else
            echo "❌ $1 installation failed. You can try to install it manually or if you are not on Debian, use your package manager."
            exit 1
        fi
    else
        echo "✅ $1 is already installed."
    fi
}

install_additional_package() {
    echo -e "Do you want to install $1? (y/n) ${RED}Only if you have ${YELLOW}apt${RED} as package manager${NC}"
    read -r response
    if [ "$response" = "y" ]; then
        install_apt "$1"
    else
        sed -i "/alias $1 /d" $zshrc_file
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
    if ! type zsh &>/dev/null; then
        echo "⌛ zsh is not installed. Installing..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        echo "✅ zsh installed successfully."
    else
        echo "✅ zsh is already installed."
    fi
}

install_oh_my_zsh() {
    # Check if oh-my-zsh is installed
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo -e "oh-my-zsh is not installed. Installing... ${RED} Please exit the shell after installation ${NC}"
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
        # Install p10k
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME"/powerlevel10k
        # Install p10k theme on OMZ
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
    else
        echo "✅ powerlevel10k is already installed."
    fi
}

install_zinit() {
    if type zinit &>/dev/null; then
        echo "⌛ zinit could not be found, installing now..."
        if bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"; then
            echo "✅ zinit is installed. You can now use it to install plugins."
        else
            echo "❌ zinit installation failed. Please try to install it manually."
            exit 1
        fi
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

check_dependency() {
    if ! command -v "$1" &>/dev/null; then
        echo -e " ${GREEN}$1${RED} is not installed,${NC} please install it and re-run the installation"
        exit 0;
    fi
}

## Main

for dep in "${dependencies[@]}"; do
    check_dependency "$dep"
done

install_zsh

copy_config_files

install_oh_my_zsh

install_powerlevel10k

install_zinit

install_navi

install_fzf

additional_packages=("bat" "zoxide")
for package in "${additional_packages[@]}"; do
    install_additional_package "$package"
done

# reload zsh
zsh
