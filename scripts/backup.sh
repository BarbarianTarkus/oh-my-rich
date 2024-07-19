#!/bin/bash

echo
echo "  💾 Backing up configuration files... 💾"
echo "     ---------------------------------  "

config_location=configuration
zshrc_file=$config_location/zshrc.bak
p10k_file=$config_location/p10k.zsh.bak

# zsh configuration
if [ -f ~/.zshrc ]; then
    if [ ~/.zshrc -nt $zshrc_file ]; then
        echo "  ❌ ~/.zshrc is newer than $zshrc_file"
        echo "     Original file: $(date -r ~/.zshrc)"
        echo "     Backup file: $(date -r $zshrc_file)"
        read -p "    Do you want to back up ~/.zshrc? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "  ⌛ Backing up current ~/.zshrc"
            if cp -a ~/.zshrc "$zshrc_file"; then
                echo "  ✅ Backup of ~/.zshrc successful"
            else
                echo "  ❌ Error: Backup of ~/.zshrc failed"
            fi
        else
            echo "  ⏩ Skipping backup of ~/.zshrc"
        fi
    else
        echo "  ✅ Current .zshrc.bak is already backed up"
    fi
else
    echo "  ❌ Error: ~/.zshrc does not exist"
fi

# p10k theme configuration
if [ -f ~/.p10k.zsh ]; then
    if [ ~/.p10k.zsh -nt $p10k_file ]; then
        echo "  ❌ ~/.p10k.zsh is newer than $p10k_file"
        echo "     Original file: $(date -r ~/.p10k.zsh)"
        echo "     Backup file: $(date -r $p10k_file)"
        read -p "    Do you want to back up ~/.p10k.zsh? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "  ⌛ Backing up current ~/.p10k.zsh"
            if cp -a ~/.p10k.zsh "$p10k_file"; then
                echo "  ✅ Backup of ~/.p10k.zsh successful"
            else
                echo "  ❌ Error: Backup of ~/.p10k.zsh failed"
            fi
        else
            echo "  ⏩ Skipping backup of ~/.p10k.zsh"
        fi
    else
        echo "  ✅ Current .p10k.zsh.bak is already backed up"
    fi
else
    echo "  ❌ Error: ~/.p10k.zsh does not exist"
fi

echo
