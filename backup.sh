#!/bin/bash

echo "  💾 Backing up configuration files... 💾"
echo "     ---------------------------------  "


# zsh configuration
if [ ~/.zshrc -nt zshrc.bak   ]; then
    echo "  ❌ Backing up current .zshrc"
    cp ~/.zshrc zshrc.bak
else 
    echo "  ✅ Current .zshrc.bak is already backed up"
fi

# p10k theme configuration
if [ ~/.p10k.zsh -nt p10k.zsh.bak   ]; then
    echo "  ❌ Backing up current .p10k.zsh"
    cp ~/.p10k.zsh  p10k.zsh.bak
else 
    echo "  ✅ Current .p10k.zsh.bak is already updated"
fi
# Oh-My-Zsh configuration
#cp -r -f -a ~/.oh-my-zsh/custom/plugins .
