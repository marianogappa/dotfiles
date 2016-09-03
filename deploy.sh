#!/bin/bash

# Fail on error; echo each ran line and expand any env variables
set -e

if [ "$DOTFILES" = "" ]
then
    echo '$DOTFILES is not set.'
    exit 1
fi

(
    set -vx
    ln -sf "$DOTFILES/.bashrc" $HOME/.bashrc
    ln -sf "$DOTFILES/.bash_profile" $HOME/.bash_profile
    ln -sf "$DOTFILES/.gitconfig" $HOME/.gitconfig
    ln -sf "$DOTFILES/.gitignore_global" $HOME/.gitignore_global
)

echo -e "\nOK! The script reached here, which means it succeeded!\n"
