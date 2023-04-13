#!/bin/bash

# Install zsh
sudo apt install zsh

# Install OMZ
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

#sed 's,ZSH_THEME=[^;]*,"ZSH_THEME="powerlevel10k/powerlevel10k",' -i ~/.zshrc

# Restore zsh config
cp zshrc.bak ~/.zshrc

# Restore theme config
cp p10k.zsh.bak ~/.p10k.zsh



# Restore plugin config
#cp -r plugins ~/.oh-my-zsh/custom/plugins

# Install antigen
curl -L git.io/antigen > ~/.antigen.zsh

# Install antigen plugins
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

# Install Navi
bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)

# Install fzf a Navi Depenency
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install


source ~/.zshrc

echo "For navi Cheatshet Repos run command:"
echo 
echo "navi repo browse"
