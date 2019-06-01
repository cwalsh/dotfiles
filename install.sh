#!/bin/bash

# Thanks to https://stackoverflow.com/questions/59895/get-the-source-directory-of-a-bash-script-from-within-the-script-itself for saving me time
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DOTFILES_DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
git submodule update --init --recursive

cd ~
declare -a dotfiles=(".bashrc" ".bash_profile" ".gitconfig" ".gitignore_global" ".vim" ".vimrc")
for dotfile in "${dotfiles[@]}"
do
  echo $dotfile
  ln -nfs $DOTFILES_DIR/$dotfile $dotfile
done
