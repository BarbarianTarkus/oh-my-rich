#!/bin/bash

# Verificar si zsh está instalado
if ! command -v zsh &> /dev/null; then
    echo "zsh no está instalado. Instalando..."
    sudo apt install -y zsh
else
    echo "zsh ya está instalado."
fi

# Verificar si oh-my-zsh está instalado
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "oh-my-zsh no está instalado. Instalando..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "oh-my-zsh ya está instalado."
fi

# Verificar si powerlevel10k está instalado
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "powerlevel10k no está instalado. Instalando..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
    echo "powerlevel10k ya está instalado."
fi

# Verificar si antigen está instalado
if ! command -v antigen &> /dev/null; then
    echo "antigen no está instalado. Instalando..."
    curl -L git.io/antigen > ~/.antigen.zsh
else
    echo "antigen ya está instalado."
fi

# Verificar si navi está instalado
if ! command -v navi &> /dev/null; then
    echo "navi no está instalado. Instalando..."
    bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)
else
    echo "navi ya está instalado."
fi

# Verificar si fzf está instalado
if ! command -v fzf &> /dev/null; then
    echo "fzf no está instalado. Instalando..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
else
    echo "fzf ya está instalado."
fi

# Restaurar zsh config
cp ~/.zshrc ~/.zshrc.bak
cp zshrc ~/.zshrc

# Restaurar theme config
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

# Recargar la configuración de zsh
source ~/.zshrc

sudo apt -y install bat 


echo "Para navegar por los repositorios de Cheatshet de navi, ejecute el comando:"
echo 
echo "navi repo browse"
