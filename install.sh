#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# sore the calling directory to return later
CALLING_DIR=$PWD

# update/init submodules
cd $DIR
echo "updating git modules..."
git submodule init
git submodule update --init --recursive

# move vim stuff
echo "setting up vim files..."
for FILENAME in vimrc vim
do
	if [ -e $HOME/.$FILENAME ]; then
		echo "Moving old .$FILENAME to .${FILENAME}.bak"
		mv $HOME/.$FILENAME $HOME/.${FILENAME}.bak
	fi
	echo "linking $DIR/vim-files/$FILENAME $HOME/.$FILENAME"
	ln -s $DIR/vim-files/$FILENAME $HOME/.$FILENAME
done

echo "installing bundles (vim will appear)..."
vim +BundleInstall +qall

# YouCompleteMe is slow to setup, so don't do it if we don't have to
if [ -e $DIR/.youcompletemesetup ]; then
	echo "YouCompleteMe already setup, skipping... (remove .youcompletemesetup to force)"
else
	echo "setting up YouCompleteMe..."
	cd vim-files/vim/bundle/YouCompleteMe
	./install.sh --clang-completer
	cd $DIR
	touch .youcompletemesetup
fi

# move tmux stuff
echo "setting up tmux files..."
for FILENAME in tmux.conf
do
	if [ -f $HOME/.${FILENAME} ] || [ -L $HOME/.$FILENAME ]; then
		echo "Moving old .$FILENAME to .${FILENAME}.bak"
		mv $HOME/.$FILENAME $HOME/.${FILENAME}.bak
	fi
	echo "linking $DIR/tmux-files/$FILENAME $HOME/.$FILENAME"
	ln -s $DIR/tmux-files/$FILENAME $HOME/.$FILENAME
done

echo "setting up bash files..."
for FILENAME in bashrc bash_profile
do
	if [ -f $HOME/.${FILENAME} ] || [ -L $HOME/.$FILENAME ]; then
		echo "Moving old .$FILENAME to .${FILENAME}.bak"
		mv $HOME/.$FILENAME $HOME/.${FILENAME}.bak
	fi
	echo "linking $DIR/bash-files/$FILENAME $HOME/.$FILENAME"
	ln -s $DIR/bash-files/$FILENAME $HOME/.$FILENAME
done

echo "setting up zsh files..."
for FILENAME in zshrc oh-my-zsh
do
	if [ -f $HOME/.${FILENAME} ] || [ -L $HOME/.$FILENAME ]; then
		echo "Moving old .$FILENAME to .${FILENAME}.bak"
		mv $HOME/.$FILENAME $HOME/.${FILENAME}.bak
	fi
	echo "linking $DIR/zsh-files/$FILENAME $HOME/.$FILENAME"
	ln -s $DIR/zsh-files/$FILENAME $HOME/.$FILENAME
done

# set up powerline
echo "setting up powerline..."


cd $CALLING_DIR
