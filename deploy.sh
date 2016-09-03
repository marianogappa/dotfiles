#!/bin/bash

# Fail on error; echo each ran line and expand any env variables
set -evx

ln -sf "$DOTFILES/.bashrc" $HOME/.bashrc
ln -sf "$DOTFILES/.bash_profile" $HOME/.bash_profile
