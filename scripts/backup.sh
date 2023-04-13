#!/bin/bash

echo
echo "  💾 Backing up configuration files... 💾"
echo "     ---------------------------------  "


config_location=configuration
zshrc_file=$config_location/zshrc.bak
p10k_file=$config_location/p10k.zsh.bak


# zsh configuration
if [ ~/.zshrc -nt $zshrc_file ]; then
    echo "  ❌ Backing up current ~/.zshrc"
    cp -p ~/.zshrc $zshrc_file
else 
    echo "  ✅ Current .zshrc.bak is already backed up"
fi

# p10k theme configuration
if [ ~/.p10k.zsh -nt $p10k_file  ]; then
    echo "  ❌ Backing up current ~/.p10k.zsh"
    cp -p ~/.p10k.zsh $zshrc_file
else 
    echo "  ✅ Current .p10k.zsh.bak is already updated"
fi
echo