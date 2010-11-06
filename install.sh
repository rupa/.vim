#!/bin/sh

if [ "$PWD" != "$HOME/.vim" ]; then
    echo "we aren't in $HOME/.vim"
elif [ -f "$HOME/.vimrc" ]; then
    echo "$HOME/.vimrc found"
else
    echo "linking $PWD/vimrc to $HOME/.vimrc"
    ln -s "$PWD/vimrc" "$HOME/.vimrc"
fi
